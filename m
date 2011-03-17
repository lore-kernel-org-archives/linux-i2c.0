From: Ben Gardiner <bengardiner-ScDXFp4xN3PN+rMO2ozGnw@public.gmane.org>
Subject: Re: How to put extra clock cycles on i2c cavinci, problems on
 omapl138 (logic pd som)
Date: Thu, 17 Mar 2011 10:36:35 -0400
Message-ID: <AANLkTinLBASU07dYNnYoRCbgPHGxtkx4-nzVMFgztOD7@mail.gmail.com>
References: <OF32D366B1.336E6433-ONC1257850.004650F2-C1257850.0046C1A3@sewerin.de>
	<AANLkTi=cRYbLWn9YKQFtABjg-NZ0tM1y9JHyb1QiuNVs@mail.gmail.com>
	<OFCCCD2C6E.D899BA32-ONC1257856.00307955-C1257856.00323B2B@sewerin.de>
	<AANLkTinAgDKe8GD5GQoKaJ3p2s1Pj_DWduEnp6deZu=f@mail.gmail.com>
	<OF533CF913.E277EFE5-ONC1257856.004C0321-C1257856.004E1D46@sewerin.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <OF533CF913.E277EFE5-ONC1257856.004C0321-C1257856.004E1D46-qHSRieSIjQqELgA04lAiVw@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Bastian.Ruppert-qHSRieSIjQqELgA04lAiVw@public.gmane.org
Cc: davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org, Jon Povey <jon.povey-Ean/AyPsLtfkYMGBc/C6ZA@public.gmane.org>, khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "Nori, Sekhar" <nsekhar-l0cyMroinI0@public.gmane.org>, pjohn-k0rHJ+Hhz/SB+jHODAdFcQ@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Thu, Mar 17, 2011 at 10:13 AM,  <Bastian.Ruppert-qHSRieSIjQqELgA04lAiVw@public.gmane.org> wrote:
> [...]
>> I wonder if there is YA hardware problem with i2c on the LogicPD
>> boards. I've noticed that when I don't have the UBI board connected
>> then I don't get the controller timeouts.
>>
>
> I have some effects here, too.
> We have a i2c repeater solded on our board (PCA9515AD). With this repeater
>
> i can reproduce the errer pretty fast.
> Without this repeater solded on, the mean time before failure is much
> higher.
>
> I can produce the error pretty fast with the ts_test tool. Without any
> userland
> tool using the touchscreen info or with the tool evtest, i can see the i2c
>
> action on the oscilloscope but it is hard to produce the error.
> What does this indicate to?
> Is it possible that userland can influence the kernel driver timing to
> promote
> the error?

I don't think that userland can influence the kernel driver timing;
based on my understanding of the driver [1] polling occurs from the
moment the device is probe()'d. Are you modprob'ing the driver right
before ts_test? Where can I see the ts_test source?

>> Have you tried using the bitbanging i2c driver? I suppose that using
>> the bitbanging i2c driver would be too much CPU overhead for polling
>> your touchscreen...
>>
>
> Yes, the bitbanging driver gives me "boiled NACK" errors or so sometimes,
> but the system do not stall. (In my opinion, bitbanging is not the elegant
> way
> to do i2c).
>
>> Have you asked about how to implement this FDF-SCL-toggle method on
>> the e2e forums?
>
> No, i did not.

Ok. I'll post then.

Best Regards,
Ben Gardiner

[1] http://lxr.linux.no/linux+v2.6.38/drivers/input/touchscreen/tps6507x-ts.c

---
Nanometrics Inc.
http://www.nanometrics.ca
