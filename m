From: CF <cfoissac-GANU6spQydw@public.gmane.org>
Subject: Request for help: accessing i2c from kernel module
Date: Wed, 29 May 2013 14:56:09 +0200
Message-ID: <51A5FAE9.2000902@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hello,

Excuse me if the question have been already answered or is obvious, but 
i don't know actually how to reach i2c busses from a kernel module (the 
kernel module is cross compiled).

The user space /dev/i2c-x are not accessibles - or i'm unable to reach 
them. I suspect i have an issue because if i understand well, /dev/i2c-x 
is logically only available in user space. The error returned is the 
following:
"error: implicit declaration of function 'ioctl'"
and i fear it could be the same for open(), because if i comment my 
ioctl calls, it does not issue an error but a warning related to 'open 
undefined'.

I can successfully write user space librairies, and compile the great 
i2ctools suite.
I have actually theses includes:
#include <linux/kernel.h>
#include <linux/module.h>

#include <linux/i2c-dev.h>
#include <fcntl.h>
#include <linux/fs.h>

Thank you very much if you can point me to some documentations where i 
could use i2c from a kernel module.
