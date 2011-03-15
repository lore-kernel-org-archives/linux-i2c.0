From: <Waldemar.Rymarkiewicz-++hxYGjEMp0AvxtiuMwx3w@public.gmane.org>
Subject: RE: [PATCH] NFC: Driver for Inside Secure MicroRead NFC chip
Date: Tue, 15 Mar 2011 14:59:09 +0200
Message-ID: <99B09243E1A5DA4898CDD8B70011144810830AA4BD@EXMB04.eu.tieto.com>
References: <1299766808-2535-1-git-send-email-waldemar.rymarkiewicz@tieto.com>
 <201103101452.54862.arnd@arndb.de> <loom.20110315T104753-187@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <loom.20110315T104753-187-eS7Uydv5nfjZ+VzJOa5vwg@public.gmane.org>
Content-Language: en-US
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi Samuel,

>The few currently available NFC stacks are all implementing 
>the NFC HCI layer in
>userspace, on top of a a more or less big HAL. By at least 
>moving the HCI layer
>down to the kernel, and having userspace talk to it through 
>netlink, we could
>eventually get rid of those HALs.

Is HCI already standarised? I can't find the spec anywhere.

/Waldek
