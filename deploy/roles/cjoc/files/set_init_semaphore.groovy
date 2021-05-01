import java.util.logging.Logger

String scriptName = "set_init_semaphore.groovy"
Logger logger = Logger.getLogger(scriptName)
logger.info("---> Starting ${scriptName}")

def env = System.getenv()
def jenkins_home = env['JENKINS_HOME']

def semaphoreFile = new File(jenkins_home + "/init_semaphore.txt")
semaphoreFile.createNewFile()
semaphoreFile.write("init is ongoing") 
