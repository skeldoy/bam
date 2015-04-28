# bam

Build all modules - a small bootstrapping class for building puppet class skeletons. 

Put this folder in your /usr/local/etc/puppet/modules catalog and go anywhere and make a test.pp with the following content:

$bamList = ["puppetclass"]

class {"bam":}


If you now run that with puppet apply (future parser should be enabled in conf or you can use --parser future as a parameter to apply)
you will see that it made a puppet class for you: puppetclass. This class is a skeleton that you can fill with puppet code. 


./manifests/install.pp - code that explains how the software or service is installed (packages needed etc)

./manifests/service.pp - code that describes the services that need to run or whatnot

./manifests/params.pp - parameters for the module itself

./manifests/init.pp - the thing that loads the class

./manifests/config.pp - code that configures the thing you want to configure


By separating the installation, service and config-code you will get a much more readable and reusable codebase. The classes
even start looking good on graphs ;)


bam takes an array as a parameter for classes to build - so you can build many skeletons if you like. It takes the classnames as the array $::bamList but you can change that behaviour if you like.


Keep in mind that you might want to quickly change bam itself. Your organisation might already have a way of doing things - secret
recipes that you might want to add to bam. I suggest using bam to build a class that you call "protoclasser" and use that to build a more advanced tool.
And that is what bam is - the very first step of metaprogramming puppet.


