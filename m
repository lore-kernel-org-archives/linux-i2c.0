From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: Intel ICHx bus driver
Date: Mon, 15 Mar 2010 12:46:48 +0100
Message-ID: <20100315124648.6dafae21@hyperion.delvare>
References: <af0693f01001270956h781f2832r928364574d3406aa@mail.gmail.com>
	<af0693f01002231521q4f99eb63ocd607670625fadfa@mail.gmail.com>
	<20100228120817.275ef279@hyperion.delvare>
	<af0693f01002280545n622b1c41v1f8c104e57fb51b6@mail.gmail.com>
	<20100228211949.3297a0ff@hyperion.delvare>
	<af0693f01003020453m7ca6891bjca4833c7fa45f44d@mail.gmail.com>
	<20100312141901.04299a55@hyperion.delvare>
	<20100312172421.5b4907e6@hyperion.delvare>
	<af0693f01003150243u4d4d76e7t71b37ecd452896ea@mail.gmail.com>
	<20100315110645.1df3e4f0@hyperion.delvare>
	<af0693f01003150412p5823d8e0j678b035b1c7cc4bb@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <af0693f01003150412p5823d8e0j678b035b1c7cc4bb-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Felix Rubinstein <felixru-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Ivo Manca <pinkel-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Mon, 15 Mar 2010 13:12:12 +0200, Felix Rubinstein wrote:
> Btw, you mentioned to disable block buffer for I2C block writes in
> 2.6.24 but I don't see any change regarding it. Is it in
> git://git.kernel.org/pub/scm/linux/kernel/git/jdelvare/staging.git

I guess you really mean 2.6.34 and not 2.6.24. The patch is in Linus'
tree since yesterday:
http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commit;h=c074c39d62306efa5ba7c69c1a1531bc7333d252

It will also be applied to the 2.6.33, 2.6.32 and 2.6.27 stable trees.

-- 
Jean Delvare
