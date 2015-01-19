From: Michael Mercier <michael.mercier-MZpvjPyXg2s@public.gmane.org>
Subject: Fwd: Py-smbus for Python 3
Date: Mon, 19 Jan 2015 10:12:15 +0100 (CET)
Message-ID: <1879153388.1899869.1421658735412.JavaMail.zimbra@inria.fr>
References: <1421658501.2937.2@smtp.inria.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1421658501.2937.2-YAXBhf1W29QAs8EywTwl9A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi,

I am working on a project that use the py-smbus module. The problem is 
I am using python 3.x and the py-smbus library is not compatible with 
this version.

I found a lot of hack to do so, like:
http://www.raspberrypi.org/forums/viewtopic.php?f=32&t=22348
http://procrastinative.ninja/2014/07/21/smbus-for-python34-on-raspberry/
http://comments.gmane.org/gmane.linux.drivers.i2c/11290
http://www.spinics.net/lists/linux-i2c/msg08427.html

I eventually manage to make it work but this code only working with 
python 3.

I like distribute it but I do not know where. Is there someone that can 
merge this upstream properly (with python2 compatibility)?

I can also put it on github to make it available so any interested people could improve it?

What do you think?

Thanks,

Michael Mercier
