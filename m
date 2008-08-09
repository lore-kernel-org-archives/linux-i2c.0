From: Rene Herman <rene.herman-cENuUygGYd//D1n+0JDH9g@public.gmane.org>
Subject: Re: [PATCH] i2c: don't autograb i2c-pca-isa
Date: Sat, 09 Aug 2008 15:49:55 +0200
Message-ID: <489DA083.3020901@keyaccess.nl>
References: <489C8015.8070804@keyaccess.nl>
	<20080809152845.45a9722c@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <20080809152845.45a9722c-ig7AzVSIIG7kN2dkZ6Wm7A@public.gmane.org>
List-Unsubscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.lm-sensors.org/pipermail/i2c>
List-Post: <mailto:i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Help: <mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=help>
List-Subscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=subscribe>
Sender: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Errors-To: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: Andrew Morton <akpm-3NddpPZAyC0@public.gmane.org>, Ingo Molnar <mingo-X9Un+BFzKDI@public.gmane.org>, Linux I2C <i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On 09-08-08 15:28, Jean Delvare wrote:

> On Fri, 08 Aug 2008 19:19:17 +0200, Rene Herman wrote:

>> Grabbing ISA bus resources without anything or anyone telling us we
>> should can break boot on randconfig/allyesconfig builds by keeping
>> resources that are in fact owned by different hardware busy and does
>> as reported by Ingo Molnar.
> 
> I don't think it makes much sense to boot randomconfig kernels. The
> i2c-pca-isa driver is for rare hardware, most people will not use it
> and certainly won't build it into the kernel. So I don't think there
> really is a problem in practice here. That being said...

Ingo actually hit this -- i2c-pca-isa "broke" his e1000 by grabbing 
IRQ10. He does randonfig builds for testing purposes (which a little 
while ago caught a dumb yet very old bug in an ALSA ISA driver which 
impressed the usefulness of such on me...)

> I am curious how many users of this driver are left. Maybe it's time to
> get rid of it.

I rather expect the number is 0 but unless it's a maintenance burden I'd 
say to keep it around if only as a "see, this is how simple it gets" 
sort of thing.

(not that the other drivers in there are wildly complex it seems upon 
looking, so, well, what do I know)

>> +static int __devinit pca_isa_match(struct device *dev, unsigned int id)
>> +{
>> +	int match = base != 0;
>> +
>> +	if (match) {
>> +		if (irq == -1)
>> +			dev_warn(dev, "using poling mode (specify irq)\n");
> 
> Spelling: polling.

Argh.

> Other than that, this looks OK. I'll queue this for 2.6.28.

Thanks.

Rene.

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
