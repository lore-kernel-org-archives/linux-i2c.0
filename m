From: Rob Herring <robherring2-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] of_i2c: Honour "status=disabled" property of device
Date: Wed, 28 Nov 2012 11:05:43 -0600
Message-ID: <50B64467.6010107@gmail.com>
References: <50B61DDA.5090109@sysgo.com> <50B638CC.6070106@wwwdotorg.org> <50B6412E.7060906@sysgo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <50B6412E.7060906-uSbOeAmDUekAvxtiuMwx3w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Alexander Sverdlin <asv-uSbOeAmDUekAvxtiuMwx3w@public.gmane.org>
Cc: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, alexander sverdlin <alexander.sverdlin.ext-OYasijW0DpE@public.gmane.org>, Jon Smirl <jonsmirl-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On 11/28/2012 10:51 AM, Alexander Sverdlin wrote:
> Hi!
> 
> On 11/28/2012 05:16 PM, Stephen Warren wrote:
>> On 11/28/2012 07:21 AM, Alexander Sverdlin wrote:
>>> of_i2c: Honour "status=disabled" property of device
>>>
>>> Currently of_i2c_register_devices() function registers all i2c devices,
>>> independently from their status property in device tree. According to
>>> "ePAPR 1.1" spec, device should only be registered if there is no
>>> "status" property, or it has "ok" (or "okay") value (see
>>> of_device_is_available()). In case of "platform devices",
>>> of_platform_device_create_pdata() checks for "status" and ensures
>>> that disabled devices are not populated. But such check for i2c buses
>>> was missing until now. Fix it.
>>
>> Do SPI and other buses (e.g. MDIO/MDIO mux?) need a similar change?
> 
> You are right, of_register_spi_devices() and of_mdiobus_register() both have exactly the same issue.
> Should it be a follow-up patch, or better to combine them to one patch?

Separate please in case there is some reason to revert. Also, I already
have a patch for i2c that does the same thing in my tree. However, your
patch is better, so I'll probably replace it with yours.

Rob
