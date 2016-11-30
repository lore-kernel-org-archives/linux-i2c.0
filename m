From: Romain Perier <romain.perier-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCH v5 1/3] i2c: pxa: Add support for the I2C units found in
 Armada 3700
Date: Wed, 30 Nov 2016 11:38:11 +0100
Message-ID: <e5c36597-d917-0555-89cd-35f68087c1c5@free-electrons.com>
References: <20161121133247.29889-1-romain.perier@free-electrons.com>
 <20161121133247.29889-2-romain.perier@free-electrons.com>
 <20161129211716.GA15594@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20161129211716.GA15594@katana>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-dev-jBu1N2QxHDJrcw3mvpCnnVaTQe2KTcn/@public.gmane.org>
Cc: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Jason Cooper <jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org>, Andrew Lunn <andrew-g2DYL2Zd6BY@public.gmane.org>, Sebastian Hesselbarth <sebastian.hesselbarth-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Gregory Clement <gregory.clement-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Thomas Petazzoni <thomas.petazzoni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Nadav Haklai <nadavh-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Omri Itach <omrii-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Shadi Ammouri <shadi-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Yahuda Yitschak <yehuday-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Hanna Hawa <hannah-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Neta Zur Hershkovits <neta-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hello,

Le 29/11/2016 à 22:17, Wolfram Sang a écrit :
>> +	if (of_device_is_compatible(np, "marvell,armada-3700-i2c")) {
>> +		i2c->fm_mask = ICR_BUSMODE_FM;
>> +		i2c->hs_mask = ICR_BUSMODE_HS;
>> +	} else {
>> +		i2c->fm_mask = ICR_FM;
>> +		i2c->hs_mask = ICR_HS;
>> +	}
>>
>>  	*i2c_types = (enum pxa_i2c_types)(of_id->data);
>>
>> @@ -1181,6 +1194,13 @@ static int i2c_pxa_probe_pdata(struct platform_device *pdev,
>>  			i2c->master_code = 0xe;
>>  		i2c->rate = plat->rate;
>>  	}
>> +	if (!strcmp(id->name, "armada-3700-i2c")) {
>> +		i2c->fm_mask = ICR_BUSMODE_FM;
>> +		i2c->hs_mask = ICR_BUSMODE_HS;
>> +	} else {
>> +		i2c->fm_mask = ICR_FM;
>> +		i2c->hs_mask = ICR_HS;
>> +	}
>
> Okay, having the same code twice is not nice as well.
>
> Sorry for missing this in the first review and going a step back, but I
> think now the best solution is to have again a REGS_A3700 struct, but we
> should extend it with new entries for the shifted bits. Then in the init
> code, you can do something like:
>
> 	i2c->fm_mask = pxa_reg_layout[i2c_type].fm_mask ?: ICR_FM;
>
> Makes sense?

Mhhhh... makes sense yes, it is simpler and would remove the duplicated 
code, yes (no no need to modify probe_dt and probe_pdata in this case).
What do you prefer everything in one commit or two seperated commit ? 
(one including the new fields for fm_mask and another one to add support 
for a3700-i2c).

Thanks,
Romain

-- 
Romain Perier, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
