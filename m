From: Alan Cox <alan-qBU/x9rampVanCEyBjwyrvXRex20P6io@public.gmane.org>
Subject: Re: [PATCH] i2c: i2c-tiny-usb: Add parameter for optional
 i2c-devices.
Date: Tue, 13 Nov 2012 22:42:51 +0000
Message-ID: <20121113224251.20b52f34@pyramind.ukuu.org.uk>
References: <50A2AC28.7050304@ahsoftware.de>
	<1352839940-7559-1-git-send-email-holler@ahsoftware.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1352839940-7559-1-git-send-email-holler-SXC+2es9fhnfWeYVQQPykw@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Alexander Holler <holler-SXC+2es9fhnfWeYVQQPykw@public.gmane.org>
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Till Harbaum <till-RcHadlBFbzVAfugRpC6u6w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Tue, 13 Nov 2012 21:52:20 +0100
Alexander Holler <holler-SXC+2es9fhnfWeYVQQPykw@public.gmane.org> wrote:

> Make it possible to define i2c-devices at the kernel command line
> or as a module parameter.
> 
> Format is devname1@addr1,devname2@addr2,...

Why not do this with your initrd, you can deal with your rtc
before mounting the real root fs.

Alan
