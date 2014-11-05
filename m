From: Matthias Klein <matthias.klein-mnoMUKZXHfEb1SvskN2V4Q@public.gmane.org>
Subject: Simultaneously access to one i2c/dev-interface from different process
 to different i2c devices
Date: Wed, 05 Nov 2014 09:58:44 +0100
Message-ID: <5459E6C4.3060107@optimeas.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hello,

is it possible from different processes to access different i2c devices 
on the same i2c bus/adapter using the i2c/dev-interface from userland?

Or can the i2c/dev-interface only ne used from a single process?


How does the simultaneously access to one adapter works for i2c device 
drivers inside the kernel?
Do they fail on a simultaneously access, or do they wait until the i2c 
adapter is ready/free for use?


Best regards,
Matthias
