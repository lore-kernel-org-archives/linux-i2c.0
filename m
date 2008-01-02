From: Roberto Marino <formica-YbGCGrJzjEK4SyVuDWiTng@public.gmane.org>
Subject: i2c-dev cross-compile error
Date: Wed, 02 Jan 2008 16:35:05 +0000
Message-ID: <1199291705.8789.9.camel@escher.metaverse>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Unsubscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.lm-sensors.org/pipermail/i2c>
List-Post: <mailto:i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Help: <mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=help>
List-Subscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=subscribe>
Sender: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Errors-To: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
To: i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi all,
I've a problem with i2c-dev on arm.
I'm trying to cross-compile i2c-dev example
(Documentation/i2c/dev-interface) for arm passing these arguments to
cross-compiler

arm-linux-gcc-3.4.1 -I/usr/local/arm/3.4.1/arm-linux/include -O2
prova_max1363.c -o prova_max1363

The error is this (too long to paste completely):
-------------------------
In file included
from /usr/local/arm/3.4.1/lib/gcc/arm-linux/3.4.1/../../../../arm-linux/sys-include/linux/sched.h:12,

from /usr/local/arm/3.4.1/lib/gcc/arm-linux/3.4.1/../../../../arm-linux/sys-include/linux/module.h:10,

from /usr/local/arm/3.4.1/lib/gcc/arm-linux/3.4.1/../../../../arm-linux/sys-include/linux/i2c.h:31,
                 from prova_max1363.c:1:
/usr/local/arm/3.4.1/lib/gcc/arm-linux/3.4.1/../../../../arm-linux/sys-include/linux/jiffies.h:16: error: parse error before "jiffies_64"
/usr/local/arm/3.4.1/lib/gcc/arm-linux/3.4.1/../../../../arm-linux/sys-include/linux/jiffies.h:20: error: parse error before "get_jiffies_64"
In file included
from /usr/local/arm/3.4.1/lib/gcc/arm-linux/3.4.1/../../../../arm-linux/sys-include/linux/sched.h:18,

from /usr/local/arm/3.4.1/lib/gcc/arm-linux/3.4.1/../../../../arm-linux/sys-include/linux/module.h:10,

from /usr/local/arm/3.4.1/lib/gcc/arm-linux/3.4.1/../../../../arm-linux/sys-include/linux/i2c.h:31,
                 from prova_max1363.c:1:
/usr/local/arm/3.4.1/lib/gcc/arm-linux/3.4.1/../../../../arm-linux/sys-include/asm/semaphore.h:18: error: parse error before "wait_queue_head_t"
/usr/local/arm/3.4.1/lib/gcc/arm-linux/3.4.1/../../../../arm-linux/sys-include/asm/semaphore.h: In function `sema_init':
/usr/local/arm/3.4.1/lib/gcc/arm-linux/3.4.1/../../../../arm-linux/sys-include/asm/semaphore.h:46: error: dereferencing pointer to incomplete type
/usr/local/arm/3.4.1/lib/gcc/arm-linux/3.4.1/../../../../arm-linux/sys-include/asm/semaphore.h:47: error: dereferencing pointer to incomplete type
/usr/local/arm/3.4.1/lib/gcc/arm-linux/3.4.1/../../../../arm-linux/sys-include/asm/semaphore.h:48: error: dereferencing pointer to incomplete type
/usr/local/arm/3.4.1/lib/gcc/arm-linux/3.4.1/../../../../arm-linux/sys-include/asm/semaphore.h: In function `sema_count':
/usr/local/arm/3.4.1/lib/gcc/arm-linux/3.4.1/../../../../arm-linux/sys-include/asm/semaphore.h:66: error: dereferencing pointer to incomplete type
In file included
from /usr/local/arm/3.4.1/lib/gcc/arm-linux/3.4.1/../../../../arm-linux/sys-include/linux/signal.h:4,

from /usr/local/arm/3.4.1/lib/gcc/arm-linux/3.4.1/../../../../arm-linux/sys-include/linux/sched.h:25,

from /usr/local/arm/3.4.1/lib/gcc/arm-linux/3.4.1/../../../../arm-linux/sys-include/linux/module.h:10,

from /usr/local/arm/3.4.1/lib/gcc/arm-linux/3.4.1/../../../../arm-linux/sys-include/linux/i2c.h:31,
                 from prova_max1363.c:1:
/usr/local/arm/3.4.1/lib/gcc/arm-linux/3.4.1/../../../../arm-linux/sys-include/linux/list.h:682:2: warning: #warning "don't include kernel headers in userspace"
In file included
from /usr/local/arm/3.4.1/lib/gcc/arm-linux/3.4.1/../../../../arm-linux/sys-include/asm/siginfo.h:4,

from /usr/local/arm/3.4.1/lib/gcc/arm-linux/3.4.1/../../../../arm-linux/sys-include/linux/signal.h:7,

from /usr/local/arm/3.4.1/lib/gcc/arm-linux/3.4.1/../../../../arm-linux/sys-include/linux/sched.h:25,

from /usr/local/arm/3.4.1/lib/gcc/arm-linux/3.4.1/../../../../arm-linux/sys-include/linux/module.h:10,

from /usr/local/arm/3.4.1/lib/gcc/arm-linux/3.4.1/../../../../arm-linux/sys-include/linux/i2c.h:31,
                 from prova_max1363.c:1:
/usr/local/arm/3.4.1/lib/gcc/arm-linux/3.4.1/../../../../arm-linux/sys-include/asm-generic/siginfo.h: At top level:
/usr/local/arm/3.4.1/lib/gcc/arm-linux/3.4.1/../../../../arm-linux/sys-include/asm-generic/siginfo.h:58: error: size of array `_pad' is too large
In file included
from /usr/local/arm/3.4.1/lib/gcc/arm-linux/3.4.1/../../../../arm-linux/sys-include/linux/sched.h:29,

from /usr/local/arm/3.4.1/lib/gcc/arm-linux/3.4.1/../../../../arm-linux/sys-include/linux/module.h:10,

from /usr/local/arm/3.4.1/lib/gcc/arm-linux/3.4.1/../../../../arm-linux/sys-include/linux/i2c.h:31,
                 from prova_max1363.c:1:
-----------------------------

This is the source, any idea? :

#include <linux/i2c.h>
#include <linux/i2c-dev.h>
#include <stdio.h>
#include <stdlib.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>

#define I2C_SLAVE 0x0703 /* Change slave address */ 


int main(void)
{
        int file;
        int adapter_nr = 0;
        char filename[20];
        int addr = 0x34;
        char command[3];
        char buf[3];

        sprintf(filename,"/dev/i2c-%d", adapter_nr);

        if ((file = open(filename,O_RDWR)) < 0) {
                printf("Open error\n");
                /* ERROR HANDLING; you can check errno to see what went
wrong */
                exit(1);
        }

        if (ioctl(file,I2C_SLAVE,addr) < 0) {
                printf("ioctl error");
                /* ERROR HANDLING; you can check errno to see what went
wrong */
                exit(1);
        }

        command[0] = addr;
        buf[1] = 0x61;
        buf[2] = 0xd0;
        if ( write(file,buf,3) != 3) {
                printf("Write error");
        }
        /* Using I2C Read, equivalent of i2c_smbus_read_byte(file) */
        if (read(file,buf,2) != 2) {
                /* ERROR HANDLING: i2c transaction failed */
        } else {
                /* buf[0] contains the read byte */
                printf("%c, %c", buf[0],buf[1]);
	}
	return 0;
}

                                                                                                                                                                






-- 

(o_     Roberto (aka formica) Marino
//\     Computer Engineering Student
V_/_    Free Software User - Me|Lug Member
        keyID = 641AE37D on pgp.mit.edu

Per favore non mandatemi allegati in Word o PowerPoint.
Si veda http://www.gnu.org/philosophy/no-word-attachments.html
