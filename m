From: Michael Lawnick <ml.lawnick-Mmb7MZpHnFY@public.gmane.org>
Subject: Re: About one i2c failure issue after system reset
Date: Mon, 21 Nov 2011 12:49:09 +0100
Message-ID: <4ECA3AB5.8060103@gmx.de>
References: <CAFQ4atSRapXvhBnm=nH__zz2U=XRjxN4GK-JsXT=AEcKybANZA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAFQ4atSRapXvhBnm=nH__zz2U=XRjxN4GK-JsXT=AEcKybANZA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jason Hui <jason.hui-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Am 21.11.2011 08:35, schrieb Jason Hui:
> Hi, Ben, Jean,
> 
> I have one issue about the i2c failure: there will be on-going i2c
> transfer while system get reset.
> At the time when the reset happens, the slave may pull the SDA to
> LOW.After reset, the i2c master may reset, but
> the slave may still pull the SDA to LOW since there is no reset pin
> for the slave device to do i2c reset, thus
> result in the further i2c access failure forever unless we completely
> power off the system by pulling out
> the battery.
> 

This is a common failure scenario and should be solved by your adapter
driver automatically by issuing 9 clock cycles on detection.
-- 
KR
Michael
