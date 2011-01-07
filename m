From: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Subject: Re: [PATCH 3/6] i2c/pxa2xx: Add PCI support for PXA I2C controller
Date: Fri, 7 Jan 2011 08:57:06 -0700
Message-ID: <AANLkTikSrGaZoigQS4pU8bnHx4-PpmSRW-qTOo+joi=U@mail.gmail.com>
References: <1294246263-31960-1-git-send-email-bigeasy@linutronix.de>
 <1294246263-31960-4-git-send-email-bigeasy@linutronix.de> <20110105230342.GO8638@n2100.arm.linux.org.uk>
 <20110105230834.GA26399@suse.de> <20110106105051.GA12146@www.tglx.de>
 <20110106111231.GD31708@n2100.arm.linux.org.uk> <20110106115026.GA18081@www.tglx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20110106115026.GA18081-Hfxr4Dq0UpYb1SvskN2V4Q@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sebastian Andrzej Siewior <bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
Cc: Russell King - ARM Linux <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Greg KH <gregkh-l3A5Bk7waGM@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, eric.y.miao-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, sodaville-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, Dirk Brandewie <dirk.brandewie-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Thu, Jan 6, 2011 at 4:50 AM, Sebastian Andrzej Siewior
<bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org> wrote:
> * Russell King - ARM Linux | 2011-01-06 11:12:31 [+0000]:
>
>>Please see my email where I described the lifetime rules. =A0Let's sa=
y
>>your module is removed. =A0In doing so, you call platform_device_unre=
gister()
>>followed by kfree(). =A0After this, your module is removed from the s=
ystem
>>and the memory backing the module code is unmapped.
>>
>>If something holds a reference to the platform device, then that's ju=
st
>>waiting for an OOPS to happen. =A0When those references are finally g=
iven
>>up, your release function will be called - but the code has been unma=
pped.
>
> I got that. That is why I'm going go to use allready provided functio=
ns
> (platform_device_register_resndata() in this case) so I'm no longer
> allocating any memory. So I'm only holding a struct which is pointing=
 to
> the platform_device. Everything else is unmapped by the driver core.
>
> So I just have just to of_device_node_put() myself. Hmmm.
>
> Grant, who is calling of_device_node_put() on nodes assigned in
> of_register_spi_devices() & of_i2c_register_devices()? I can't find a=
ny
> reference. The spi part is not putting the node or removing the irq
> mapping in error case so I guess there must be some magic triggered
> somewhere.

No, it is just a deficiency on the spi and i2c dt support at the
moment.  It needs to be added.  However, since the flattree is
currently entirely static (nodes don't get freed) the mismatched
reference counting isn't immediately an issue.  However, it will
become a problem when add-in boards (like xilinx fpgas) start using
the dt to describe internal devices.

> Also adap->dev.of_node and master->dev.of_node has to be
> non-null for the device assignment to work. Who is putting these node=
s
> back? I see drivers (i2c-cpm & i2c-mpc) taking refs but I fail to fin=
d a
> place where it is put back.

Same issue.

g.

--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
