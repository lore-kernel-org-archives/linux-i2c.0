From: sathyanarayanan kuppuswamy
	<sathyanarayanan.kuppuswamy-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: Re: [PATCH v1 1/1] i2c: Add acpi support to enumerate i2c mux clients
Date: Tue, 02 Jun 2015 17:38:20 -0700
Message-ID: <556E4C7C.8050009@linux.intel.com>
References: <cover.1428546834.git.sathyanarayanan.kuppuswamy@linux.intel.com> <b57c66fc1b7e790bd8c3e525faf65ce46cd91f23.1428546834.git.sathyanarayanan.kuppuswamy@linux.intel.com> <20150602161953.GA12451@katana>
Reply-To: sathyanarayanan.kuppuswamy-VuQAYsv1563Yd54FQh9/CA@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20150602161953.GA12451@katana>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, srinivas.pandruvada-VuQAYsv1563Yd54FQh9/CA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi Sang

Thanks for your comments. Please find my reply inline.

On 06/02/2015 09:19 AM, Wolfram Sang wrote:
>> +#ifdef CONFIG_ACPI
>> +static void acpi_i2c_mux_register_devices(struct i2c_adapter *adap,
>> +					  struct device *mux_dev)
>> +{
>> +	acpi_handle handle;
>> +	acpi_status status;
>> +
>> +	handle = ACPI_HANDLE(mux_dev);
>> +	if (!handle)
>> +		return;
>> +
>> +	status = acpi_walk_namespace(ACPI_TYPE_DEVICE, handle, 1,
>> +				     acpi_i2c_add_device, NULL,
>> +				     adap, NULL);
>> +
>> +	if (ACPI_FAILURE(status))
>> +		dev_warn(mux_dev, "mux adapter slave enumeration fails\n");
>> +}
>> +#else /* !CONFIG_ACPI */
>> +static inline void acpi_i2c_mux_register_devices(struct i2c_adapter *adap,
>> +						 struct device *mux_dev) { }
>> +#endif /* CONFIG_ACPI */
> IMO, this shares too much code with acpi_i2c_register_devices(). And it
> pulls in ACPI into mux.c which is not really needed.
Even though mux is a just a virtual adapter without any ACPI ID, Its 
slaves are a still actual devices and needs to be enumerated by ACPI. So 
think its accptable to include ACPI in mux code. Don't you agree ?

Also ACPI handle code in this function is slightly different from 
acpi_i2c_register_devices() code.

>
> What about naming the above function
> acpi_i2c_register_devices_from_dev() and let acpi_i2c_register_devices()
If you call this function from i2c-core register device function, then 
how will you maintain the hierarchy ? We need some way to indicate that 
these devices are under mux adapter right ?
> then call it as a helper function, all this in i2c-core.c?
>
> Thanks for your patience BTW...
>

-- 
Sathyanarayanan Kuppuswamy
Android kernel developer
