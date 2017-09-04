From: "Mohandass, Divagar" <divagar.mohandass-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: [PATCH 1/3] dt-bindings: add "size" property.
Date: Mon, 4 Sep 2017 10:46:04 +0000
Message-ID: <7B8CE47BD58441468D2BB13285B50E6031DE8164@BGSMSX107.gar.corp.intel.com>
References: <1501173789-25959-1-git-send-email-divagar.mohandass@intel.com>
 <1501173789-25959-2-git-send-email-divagar.mohandass@intel.com>
 <20170803202734.rqyoiqhqvonvvtca@rob-hp-laptop>
 <7B8CE47BD58441468D2BB13285B50E6031DB615E@BGSMSX107.gar.corp.intel.com>
 <20170904085738.vzp3cwvpema5oxvz@ninjato>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170904085738.vzp3cwvpema5oxvz@ninjato>
Content-Language: en-US
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "mark.rutland-5wv7dgnIgG8@public.gmane.org" <mark.rutland-5wv7dgnIgG8@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "Mani, Rajmohan" <rajmohan.mani-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org


>-----Original Message-----
>From: Wolfram Sang [mailto:wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org]
>Sent: Monday, September 04, 2017 2:28 PM
>To: Mohandass, Divagar <divagar.mohandass-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
>Cc: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>; mark.rutland-5wv7dgnIgG8@public.gmane.org;
>devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; linux-
>kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; Mani, Rajmohan <rajmohan.mani-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
>Subject: Re: [PATCH 1/3] dt-bindings: add "size" property.
>
>
>> If you want to use an existing ID for an eeprom for a different size,
>> there is no way to override it currently.
>
>Can you give an example for that?

There is a CAT24C16/GT24C16S NVMEM chip part of the OV13858
camera module and it is connected to i2c bus on Intel KBL board.
This device will use the existing ACPI ID INT3499 for an eeprom of size 2048 byte.

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
