import logging
import boto3
import botocore
import os
import sys
from botocore.config import Config
from botocore.exceptions import ClientError

LOGGER = logging.getLogger()
LOGGER.setLevel(logging.INFO)
LOG_GROUP_NAME = None
LOG_STREAM_NAME = None

CONFIG = Config(
    retries=dict(
        max_attempts=20
    )
)

s3 = boto3.resource('s3', config=CONFIG, region_name='eu-west-2')

def error_handler(lineno, error):

    LOGGER.error('The following error has occurred on line: %s', lineno)
    LOGGER.error(str(error))
    sess = boto3.session.Session()
    region = sess.region_name

    raise Exception("https://{0}.console.aws.amazon.com/cloudwatch/home?region={0}#logEventViewer:group={1};stream={2}".format(region, LOG_GROUP_NAME, LOG_STREAM_NAME))

def gets3content():
    s3_bucket_name = os.getenv('s3_bucket_name')

    try:
        s3.Bucket(s3_bucket_name).download_file('haproxy.cfg', '/etc/haproxy/haproxy.cfg')
    except Exception as err:
        error_handler(sys.exc_info()[2].tb_lineno, err)

    try:
        os.system("/etc/ssl/certs/make-dummy-cert /etc/ssl/certs/self-signed-cert")
    except Exception as err:
        error_handler(sys.exc_info()[2].tb_lineno, err)

    try:
        os.system("sudo haproxy -f /etc/haproxy/haproxy.cfg -p /var/run/haproxy.pid -sf $(cat /var/run/haproxy.pid)")
    except Exception as err:
        error_handler(sys.exc_info()[2].tb_lineno, err)

gets3content()
