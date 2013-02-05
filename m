From: "Heasley, Seth" <seth.heasley-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: [PATCH v7] i2c: Adding support for Intel iSMT SMBus 2.0 host
 controller
Date: Tue, 5 Feb 2013 01:13:56 +0000
Message-ID: <DEC3922D1904474A8862C7BFF516EA9A59B4A8B8@ORSMSX101.amr.corp.intel.com>
References: <1359402232-21369-1-git-send-email-nhorman@tuxdriver.com>
 <1360007650-26272-1-git-send-email-nhorman@tuxdriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1360007650-26272-1-git-send-email-nhorman-2XuSBdqkA4R54TAoqtyWWQ@public.gmane.org>
Content-Language: en-US
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Neil Horman <nhorman-2XuSBdqkA4R54TAoqtyWWQ@public.gmane.org>, "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Cc: "Brown, Bill E" <bill.e.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hi Neil,

>General note - Seth had mentioned to me that he was unable to get writes to
>work on his system.  I'm not sure of the details, but I've done some
>rudimentary read/write testing here on my system, and it seems to work well
>(for the limited testing I can do).  Seth if you could please provide details of
>your testing, or give this patch a try, I would appreciate it.

Whatever issues I was having with the previous patch, they appear to be resolved.  I was able to do testing similar to yours, albeit using an external slave device.  I'm not seeing the device at 0x54 on my system.  But reads and writes both worked.

-Seth
