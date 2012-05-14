From: "Renz, Bernhard" <bernhard.renz-//tT4aWmXyZBDgjK7y7TUQ@public.gmane.org>
Subject: Howto compile py-smbus with python 3.2
Date: Mon, 14 May 2012 11:16:00 +0000
Message-ID: <DDF9A29ED50FA94F83C55CFA4BB8EF5F08323B@011-DB3MPN1-023.MGDPHG.emi.philips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Language: en-US
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hello @All,

i try to compile i2c-tools-3.1.0 py-smbus, smbusmodule.c with the following command under Ubuntu 12.04:
python3.2 ./setup.py build

But it fail with the following errors:
running build
running build_ext
building 'smbus' extension
gcc -pthread -DNDEBUG -g -fwrapv -O2 -Wall -Wstrict-prototypes -g -fstack-protector --param=ssp-buffer-size=4 -Wformat -Wformat-security -Werror=format-security -fPIC -I/usr/include/python3.2mu -c smbusmodule.c -o build/temp.linux-x86_64-3.2/smbusmodule.o


smbusmodule.c: In function 'SMBus_dealloc':
smbusmodule.c:94:6: error: 'SMBus' has no member named 'ob_type'
smbusmodule.c: In function 'SMBus_list_to_data':

With Python 2.7 it works. So it seems that the smbusmodule.c is written for Python 2.7.
I googled a bit, and found the following article where the changes in the c extentation between Python 2.X and Python 3 is described (espancially the ob_type problem):
http://python3porting.com/cextensions.html

Citation:
Another change in the object header is that the PyObject_HEAD macro has changed so that ob_type is now in a nested structure. This means you no longer can pick the ob_type directly from the struct, so code like ob->ob_type stops working. You should replace this with Py_TYPE(ob). The Py_TYPE macro doesn't appear until Python 2.6, so to support earlier versions we make another #ifndef:
#ifndef Py_TYPE
    #define Py_TYPE(ob) (((PyObject*)(ob))->ob_type)
#endif
In both cases the definitions above are taken directly from the Python 2.6 headers, where they are defined for forward compatibility purposes with Python 3. They work well in earlier Python versions as well, so this is a trick you can use as a general rule; if you need to use a macro that is defined in Python 3 and Python 2.6, just steal the Python 2.6 or Python 2.7 definition and put it inside an #ifndef.


Has anybody smbusmodule.c port to use with python 3?

With kind regards
Bernhard


________________________________
The information contained in this message may be confidential and legally protected under applicable law. The message is intended solely for the addressee(s). If you are not the intended recipient, you are hereby notified that any use, forwarding, dissemination, or reproduction of this message is strictly prohibited and may be unlawful. If you are not the intended recipient, please contact the sender by return e-mail and destroy all copies of the original message.
