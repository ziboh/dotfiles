import os
from loguru import logger

def test(a = 1):
    logger.info("Testing Virtualenv")
    logger.debug("pid:" + str(os.getpid()))
    logger.error("Error")
    match a:
        case 1:
            logger.info("1")
        case 2:
            logger.info("2")
        case _:
            logger.info("Other number")

if __name__ == "__main__":
   test(10)
