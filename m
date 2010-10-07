From: Rory Filer <rfiler-usJ8hg9QsBLWpu6QEFMNjNBPR1lH4CV8@public.gmane.org>
Subject: Newbie Question About Dev-Interface Method
Date: Thu, 7 Oct 2010 14:37:57 -0700
Message-ID: <8F90F944E50427428C60E12A34A309D2308DA559B4@carmd-exchmb01.sierrawireless.local>
References: <1286480883-25589-1-git-send-email-rklein@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1286480883-25589-1-git-send-email-rklein-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Content-Language: en-US
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hi

I'm working on a proof-of-concept device which contains several chips connected to the same adapter (/dev/ic2-0) on the I2C bus. Some of these have kernel-space drivers (e.g. GPIO Expander) and some don't. For the ones that don't I've opted to use the method described in the kernel Documentation/i2c/dev-interface document. This works great and does all I need for now. This is the general procedure I'm following as outlined in kernel - Documentation/i2c/dev-interface. 

- open /dev/i2c-N
- Set the chip's address by calling ioctl(file, I2C_SLAVE, address)
- interact with the chip using read/write or smb calls, etc.
- close the file when done

I'm assuming that a kernel space chip driver like our gpio expander (pca953x.c) also uses the same adapter driver as my user-space application since that expander chip is on the same bus. My question is, what happens if a kernel driver is using the bus at the same time my user-mode application is? Even if the user space app. may not be running when the chip driver runs, the adapter has an address written into it via the ioctl() call, I noted above. Can unpredictable results occur in this scenario? I think I could protect against it by writing a thread to serialize accesses to the I2C bus, but that only works if my entire application is running inside one process. I'm hoping someone on the list might be able to advise. 

Regards,

Rory
