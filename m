From: Eddie James <eajames-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCH 6/6] Documentation/devicetree: Add FSI-attached I2C master
 dt bindings
Date: Tue, 27 Jun 2017 12:28:14 -0500
Message-ID: <901bb9e4-a7b1-ce24-c68b-d96b61e1b274@linux.vnet.ibm.com>
References: <1498505375-1454-1-git-send-email-eajames@linux.vnet.ibm.com>
 <1498505375-1454-7-git-send-email-eajames@linux.vnet.ibm.com>
 <ec4a5fec-fea0-09a7-8559-99d8eb071093@ozlabs.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <ec4a5fec-fea0-09a7-8559-99d8eb071093-mnsaURCQ41sdnm+yROfE0A@public.gmane.org>
Content-Language: en-US
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jeremy Kerr <jk-mnsaURCQ41sdnm+yROfE0A@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, joel-U3u1mxZcP9KHXe+LvDLADg@public.gmane.org, andrew-zrmu5oMJ5Fs@public.gmane.org, "Edward A. James" <eajames-r/Jw6+rmf7HQT0dZR+AlfA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org



On 06/26/2017 08:06 PM, Jeremy Kerr wrote:
> Hi Eddie,
>
>> +Required properties:
>> + - compatible = "ibm,i2cm-fsi";
>> + - reg = < address size >;		: The FSI CFAM address and address space
>> +					  size.
>> + - #address-cells = <1>;		: Number of address cells in child nodes
>> + - #size-cells = <0>;			: Number of size cells in child nodes.
>> + - child nodes				: Nodes to describe ports off the I2C
>> +					  master.
>> +
>> +Child node required properties:
>> + - reg = < port number >		: The port number on the I2C master.
>> +
>> +Examples:
>> +
>> +    i2cm@1800 {
>> +        compatible = "ibm,i2cm-fsi";
>> +        reg = < 0x1800 0x400 >;
>> +        #address-cells = <1>;
>> +        #size-cells = <0>;
>> +
>> +        port@0 {
>> +            reg = <0>;
>> +        };
>> +
>> +        port@1 {
>> +            reg = <1>;
>> +        };
>> +    };
> Those child nodes represent the downstream i2c buses, and so also
> contain the i2c slave devices, right? If so, you may want to document
> that, and/or add a simple device to that example (say, an EEPROM).

Yes, good point, but the driver currently wouldn't do anything with that 
device information. It doesn't keep a list of populated devices on the 
bus or anything. Still worth adding them to the device tree?

Thanks,
Eddie

>
> Cheers,
>
>
> Jeremy
>

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
