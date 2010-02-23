From: Denis Turischev <denis-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org>
Subject: Re: [PATCH v3 1/3] MFD: introduce lpc_sch for Intel SCH LPC bridge
Date: Tue, 23 Feb 2010 11:25:59 +0200
Message-ID: <4B839F27.2040003@compulab.co.il>
References: <4B73DAEE.5080400@compulab.co.il>	<4B73DB4B.40501@compulab.co.il>	<4B7D7C13.20703@compulab.co.il>	<4B7D7CD0.7080202@oracle.com>	<4B7D807D.9060105@compulab.co.il> <20100223092636.42b083f0@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20100223092636.42b083f0-ig7AzVSIIG7kN2dkZ6Wm7A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Samuel Ortiz <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Cc: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Randy Dunlap <randy.dunlap-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>, David Brownell <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi Samuel,
Regarding renaming of sch* to isch* do you want incremental patch, or fresh version?

Denis

Jean Delvare wrote:
>> +static struct mfd_cell lpc_sch_cells[] = {
>> +	{
>> +		.name = "isch_smbus",
>> +		.num_resources = 1,
>> +		.resources = &smbus_sch_resource,
>> +	},
>> +	{
>> +		.name = "sch_gpio",
>> +		.num_resources = 1,
>> +		.resources = &gpio_sch_resource,
>> +	},
>> +};
> 
> These names are nicely inconsistent. What about "isch_gpio"?
> 

>> +obj-$(CONFIG_LPC_SCH)		+= lpc_sch.o
> 
> I don't like this name either. There is another vendor (SMSC) shipping
> LPC devices with "SCH" in their names, so there is room for confusion.
> "isch" makes it clearer that we are talking about the Intel ones.
> 
