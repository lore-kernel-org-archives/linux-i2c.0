From: Alan Cox <alan-qBU/x9rampVanCEyBjwyrvXRex20P6io@public.gmane.org>
Subject: Re: [PATCH 3/5] misc: Driver for APDS990X ALS and proximity sensors
Date: Tue, 5 Oct 2010 14:00:49 +0100
Message-ID: <20101005140049.1f25bb24@lxorguk.ukuu.org.uk>
References: <1286271779-19819-1-git-send-email-samu.p.onkalo@nokia.com>
	<1286271779-19819-4-git-send-email-samu.p.onkalo@nokia.com>
	<20101005122323.2d2870ee@lxorguk.ukuu.org.uk>
	<1286279313.21781.29.camel@4fid08082>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1286279313.21781.29.camel@4fid08082>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: samu.p.onkalo-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org
Cc: "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

> > - not clear how power_state and runtime pm interact - do we in fact need
> >   power state ?
> 
> power_state turns chip on or off. In off state runtime pm is used to
> handle bookkeeping and also handling chip state transitions including
> regulators. Other ideas than separate power_state for this kind of
> control? 

Ok that makes sense.

> 
> 
> > - lux0_input range being fixed seems inconvenient, the sensors I've got
> >   queued here use lux0_input as you do but also provide a read (and
> >   optionally writable) range limit in lux
> > 
> > static DEVICE_ATTR(lux0_sensor_range, S_IRUGO | S_IWUSR,
> > 	als_sensing_range_show, als_sensing_range_store);
> > 
> > and in your case you could just return 65535
> > 
> 
> I'll add that

Cool. I'll bash our sensor queue to fit this API
