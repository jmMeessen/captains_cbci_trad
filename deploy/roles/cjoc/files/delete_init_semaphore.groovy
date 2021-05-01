import java.util.logging.Logger

String scriptName = "delete_init_semaphore.groovy"
Logger logger = Logger.getLogger(scriptName)
logger.info("---> Starting ${scriptName}")

def env = System.getenv()
def jenkins_home = env['JENKINS_HOME']


String filename = jenkins_home + "/init_semaphore.txt"  

boolean fileSuccessfullyDeleted =  new File(filename).delete()  
println "File deleted: "+ fileSuccessfullyDeleted
logger.info("     delete result: " + fileSuccessfullyDeleted)