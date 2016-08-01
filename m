From: Jean Delvare <jdelvare@suse.de>
Subject: Re: [PATCH 1/5] i2c: i2c-smbus: prevent races on remove when Host
 Notify is used
Date: Mon, 1 Aug 2016 15:32:05 +0200
Message-ID: <20160801153205.646a04df@endymion>
References: <1469699443-22129-1-git-send-email-benjamin.tissoires@redhat.com>
	<1469699443-22129-2-git-send-email-benjamin.tissoires@redhat.com>
	<20160729111212.36b33ccc@endymion>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:60711 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753758AbcHANcJ (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Mon, 1 Aug 2016 09:32:09 -0400
In-Reply-To: <20160729111212.36b33ccc@endymion>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org

Hi Benjamin,

On Fri, 29 Jul 2016 11:12:12 +0200, Jean Delvare wrote:
> On Thu, 28 Jul 2016 11:50:39 +0200, Benjamin Tissoires wrote:
> > +static void i801_disable_host_notify(struct i2c_adapter *adapter)
> > +{
> > +	struct i801_priv *priv = i2c_get_adapdata(adapter);
> 
> You pass the adapter as the parameter, but don't need it. All you need
> is priv, which the caller has too. So you could pass priv as the
> parameter directly and avoid the glue code.
> 
> > +
> > +	if (!(priv->features & FEATURE_HOST_NOTIFY))
> > +		return;
> > +
> > +	/* disable Host Notify... */
> > +	outb_p(0, SMBSLVCMD(priv));
> 
> This assumes there's only one bit in the register, which is not true.
> There are 3 bits. I did not notice the problem during my original
> review, but in i801_enable_host_notify() you are silently zero-ing the
> other 2 bits too, which isn't nice. You should only touch the bit that
> matters to you, both here and in i801_enable_host_notify().

Thinking about it some more, I'd like to add: what if host notify was
enabled before the driver was loaded? The driver should leave the
controller in the same state it found it, ideally. We have learned in
the past that doing otherwise for PEC and I2C mode, for example, leads
to problems (lock-up on shutdown) on some systems.

This could happen with Host Notify as well. So I think you should save
the value at driver load time and restore it at unload time (same we do
with the hstcfg register.)

-- 
Jean Delvare
SUSE L3 Support
