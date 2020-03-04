#include <linux/module.h>
#include <linux/version.h>
#include <linux/kernel.h>
#include <linux/types.h>
#include <linux/kdev_t.h>
#include <linux/fs.h>
#include <linux/device.h>
#include <linux/cdev.h>
#include <asm/io.h>
#include <linux/uaccess.h>
#include <linux/delay.h>
#include <linux/slab.h>

MODULE_LICENSE("GPL");
MODULE_AUTHOR("Levente Bajczi");
MODULE_DESCRIPTION("AMP loader module");
MODULE_VERSION("0.01");

#define DEVICE_NAME         "loader"

/* TODO
 * Define the mailbox registers!
 */

static int device_open(struct inode *, struct file *);
static int device_release(struct inode *, struct file *);
static ssize_t device_read(struct file *, char *, size_t, loff_t *);
static ssize_t device_write(struct file *, const char *, size_t, loff_t *);

static dev_t first;         // Global variable for the first device number 
static struct cdev c_dev;   // Global variable for the character device structure
static struct class *cl;    // Global variable for the device class

static int device_open_count = 0;

/* This structure points to all of the device functions */
static struct file_operations file_ops = {
    .read = device_read,
    .write = device_write,
    .open = device_open,
    .release = device_release
};

static ssize_t device_read(struct file *flip, char *buffer, size_t len, loff_t *offset) {
   /* TODO */
   return -EINVAL;
}

/*
 * If the message box is clear, load the file into memory using copy_from_user and write the address to the mailbox.
 * If the message box is not clear, print an alert stating so and return -EBUSY to signal it is in use
 */

static ssize_t device_write(struct file *flip, const char *buffer, size_t len, loff_t *offset) {
    /* TODO */
}

/*
 * Keep count of the times this device has been opened/released
 * Only allow it to be opened if this count is 0 ()
 * Otherwise, return with -EBUSY
 */ 

static int device_open(struct inode *inode, struct file *file) {
    /* TODO */
    try_module_get(THIS_MODULE); // if we may open the device 
    return 0;
}

static int device_release(struct inode *inode, struct file *file) {
    /* TODO */
    module_put(THIS_MODULE);
    return 0;
}

static int __init loader_init(void) {
    /* TODO ioremap registers */


    if (alloc_chrdev_region(&first, 0, 1, DEVICE_NAME) < 0)
    {
        return -1;
    }
    if ((cl = class_create(THIS_MODULE, DEVICE_NAME)) == NULL)
    {
        unregister_chrdev_region(first, 1);
        return -1;
    }
    if (device_create(cl, NULL, first, NULL, DEVICE_NAME) == NULL)
    {
        class_destroy(cl);
        unregister_chrdev_region(first, 1);
        return -1;
    }
    cdev_init(&c_dev, &file_ops);
    if (cdev_add(&c_dev, first, 1) == -1)
    {
        device_destroy(cl, first);
        class_destroy(cl);
        unregister_chrdev_region(first, 1);
        return -1;
    }
    return 0;

}


static void __exit loader_exit(void) {
    cdev_del(&c_dev);
    device_destroy(cl, first);
    class_destroy(cl);
    unregister_chrdev_region(first, 1);
    /* TODO iounmap registers */
}


module_init(loader_init);
module_exit(loader_exit);