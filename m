From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: Intel ICHx bus driver
Date: Fri, 19 Feb 2010 10:58:41 +0100
Message-ID: <20100219105841.2bd8b16c@hyperion.delvare>
References: <af0693f01001270956h781f2832r928364574d3406aa@mail.gmail.com>
	<20100128085904.4e202de1@hyperion.delvare>
	<af0693f01001280132l4002af0fgf3137fa27ce8555e@mail.gmail.com>
	<20100128105340.41aecf64@hyperion.delvare>
	<af0693f01002182310i6678e4b5h80feb14b24b37742@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <af0693f01002182310i6678e4b5h80feb14b24b37742-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Felix Rubinstein <felixru-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi Felix,

On Fri, 19 Feb 2010 09:10:03 +0200, Felix Rubinstein wrote:
> Does ICHx support straight I2C read of arbitrary length, i.e. without doing
> write first?

No, it doesn't. The only straight read lengths supported are 0 byte
(SMBus quick command) and 1 byte (SMBus receive byte).

-- 
Jean Delvare
http://khali.linux-fr.org/wishlist.html
