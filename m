From: Tabi Timur-B04825 <B04825-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Subject: Re: [PATCH] i2c-mpc: avoid I2C abnormal after resuming from deep
 sleep
Date: Wed, 29 Feb 2012 18:08:49 +0000
Message-ID: <CAOZdJXV69jbbDbJKrLevLxe-2Qqz1wd-g6mBDwecL=r1jJ1jcA@mail.gmail.com>
References: <1330511961-22498-1-git-send-email-chenhui.zhao@freescale.com>
	<CAM=Q2ctLm8FKgTek6u9H0jzWJv1bbBUnvDHZfEA=p2ReK8ybUQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAM=Q2ctLm8FKgTek6u9H0jzWJv1bbBUnvDHZfEA=p2ReK8ybUQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Content-Language: en-US
Content-ID: <C0A110029EFA914C977DA269C71F0EE8-725oAoX4OcF2GV6JINhBVAC/G2K4zDHf@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Shubhrajyoti Datta <omaplinuxkernel-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Zhao Chenhui-B35336 <B35336-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Li Yang-R58472 <r58472-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Wed, Feb 29, 2012 at 7:02 AM, Shubhrajyoti Datta
<omaplinuxkernel-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
>
>> +#ifdef CONFIG_PM
>> + =A0 =A0 =A0 u8 fdr, dfsrr;

> How about having =A0a structure here ?

Why? He's just adding two variables in an existing structure.  Adding
a nested structure would unnecessarily complicate things.

--=20
Timur Tabi
Linux kernel developer at Freescale
