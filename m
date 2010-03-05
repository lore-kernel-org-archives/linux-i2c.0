From: "Griffis, Brad" <bgriffis-l0cyMroinI0@public.gmane.org>
Subject: RE: [PATCH 6/6] i2c: davinci: bus recovery procedure to clear the
 bus
Date: Fri, 5 Mar 2010 09:20:07 -0600
Message-ID: <F8C55F6A02E92D48BDDFC6048552C6F14E6D9F3F@dlee03.ent.ti.com>
References: <1264549293-25556-1-git-send-email-khilman@deeprootsystems.com>
	<1264549293-25556-7-git-send-email-khilman@deeprootsystems.com>
	<B85A65D85D7EB246BE421B3FB0FBB59301E235A3C2@dbde02.ent.ti.com>
	<225d086e1002050553tc1a696avce827cc115f56b1c@mail.gmail.com>
	<B85A65D85D7EB246BE421B3FB0FBB59301E2639AD8@dbde02.ent.ti.com>
	<4B702A17.3070104@mvista.com>
	<B85A65D85D7EB246BE421B3FB0FBB59301E2639D67@dbde02.ent.ti.com>
	<4B7135B3.9080104@mvista.com>
 <B85A65D85D7EB246BE421B3FB0FBB59301E263A447@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <B85A65D85D7EB246BE421B3FB0FBB59301E263A447-/tLxBxkBPtCIQmiDNMet8wC/G2K4zDHf@public.gmane.org>
Content-Language: en-US
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Nori, Sekhar" <nsekhar-l0cyMroinI0@public.gmane.org>, Philby John <pjohn-Igf4POYTYCDQT0dZR+AlfA@public.gmane.org>
Cc: "davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org" <davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>, "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

> > Right. I was also hoping to rid of cpu_is_xxx usage. The only other way
> > I could think of is to add pinmux index into i2c platform data struct.
> > What do you think is the best approach?
> >
> 
> I think passing pinmux index through platform data is fair.
> 
> Thanks,
> Sekhar

I recently was told of a clever solution for this issue which I documented here:

http://wiki.davincidsp.com/index.php/I2C_Tips#External_Slave_Device_Hanging_the_Bus_by_Holding_SDA_Low

Basically the solution was to switch to "free data format" and perform a read.  This will cause the I2C to start toggling SCL.  I mention it here because I think the "free data format" mode is available on most processors.  (The only device I know that does NOT support "free data format" is OMAP35x.)  You might have a lot less processor-specific code with this approach and it would be applicable to more devices.

I don't have any time to write the code/patch myself, but I thought I would at least toss the idea out there.

Brad
