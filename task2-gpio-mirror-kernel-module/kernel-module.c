#include <linux/module.h>                       // Necessary include for kernel modules

MODULE_LICENSE("GPL");                          // Could be any other license as well
MODULE_AUTHOR("Author Name"); 		            // Your name
MODULE_DESCRIPTION("Short description");        // Concise summary
MODULE_VERSION("0.01"); 			            // Version number

static int __init lkm_example_init(void)        // This will run when loaded
{
    printk(KERN_INFO "Hello World!");
    return 0;
}

static void __exit lkm_example_exit(void)       // This will run when unloaded
{
    printk(KERN_INFO "Goodbye World!");
}

module_init(lkm_example_init);                  // To make the correct function run
module_exit(lkm_example_exit);                  // To make the correct function run