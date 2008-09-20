From: "Marco Aurelio da Costa" <costa-nrw9SyMmU14AvxtiuMwx3w@public.gmane.org>
Subject: Re: PCA9665 support added to i2c-algo-pca and i2c-pca-isa.c
Date: Sat, 20 Sep 2008 08:09:51 -0300
Message-ID: <c76dcaf00809200409r7e0420c9rcb83a654d40e217a@mail.gmail.com>
References: <48D3B5B7.1060402@gamic.com> <20080919145500.GH4307@pengutronix.de>
	<48D3C74E.1050801@gamic.com> <20080920072131.GB12497@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <20080920072131.GB12497-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Content-Disposition: inline
List-Unsubscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.lm-sensors.org/pipermail/i2c>
List-Post: <mailto:i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Help: <mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=help>
List-Subscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=subscribe>
Sender: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Errors-To: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
To: i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi Wolfram

On Sat, Sep 20, 2008 at 4:21 AM, Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org> wrote:
>> +     if (pca_data->i2c_chip_type > I2C_PCA_CHIP_9665) {
>
> I wonder if something like I2C_PCA_CHIP_MAXVAL could be useful here.
> Then, if another chip will be added, you just need changes in the .h
> file.

You are right. Done.

>> +                     default:
>> +                             printk(KERN_WARNING
>> +                                     "%s: Invalid I2C clock speed selected."
>> +                                     "Trying default.\n", adap->name);
>
> Please mention what the default is.

Done.

>> +             clock = pca_clock(pca_data)/100; /* Hz*100 */
>
> CodingStyle (no spaces around operators)
> The comment is also a bit misleading as it is the opposite from the
> code. Please be a bit more detailed here.

Done.

>> +             if (clock < 648) {
>> +                     tlow = 255;
>> +                     thigh = (1000000-clock*raise_fall_time)/(3*clock)-tlow;
>
> CodingStyle (no spaces around operators)
> The values look a bit magic. I could find min_t*-values in the spec,
> still a reference to the section of the spec will be helpful. I think
> you could elaborate a bit more on raise_fall_time and clock < 648,
> though.

Done.

>> -     snprintf(i2c->adap.name, sizeof(i2c->adap.name), "PCA9564 at 0x%08lx",
>> -             (unsigned long) res->start);
>> +     snprintf(i2c->adap.name, sizeof(i2c->adap.name),
>> +              "PCA9564/PCA9665 at 0x%08lx",
>
> I think we could be precise here as we know the chip-type. I just got
> the idea: Do you think it is possible to detect the chip type at
> runtime? Perhaps by somehow checking the presence of the indirect
> register?

I thought the same before, but I was afraid that it would be too much
of a hack. As the user has to know which chip he has (there is no
auto-detection at all for this), I thought that this is not really a
necessity. I can do it if you think that it is a good idea.

I will send you the corrected patch after your comment on the
auto-detection issue.

Best regards,

Marco

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
