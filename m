From: "Huang, Shane" <Shane.Huang-5C7GfCeVMHo@public.gmane.org>
Subject: RE: [PATCH 1/2] i2c-piix4: Add support for AMD ML and CZ SMBus
 changes
Date: Thu, 23 Jan 2014 22:26:49 +0000
Message-ID: <43EB3AB3EEFE8D43B525F4D2EAF507E1090ADBB0@SCYBEXDAG01.amd.com>
References: <1390428346-2235-1-git-send-email-shane.huang@amd.com>
 <20140123132740.122c0f8a@endymion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20140123132740.122c0f8a-R0o5gVi9kd7kN2dkZ6Wm7A@public.gmane.org>
Content-Language: en-US
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "Peng, Carl" <Carl.Peng-5C7GfCeVMHo@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, "Huang, Shane" <Shane.Huang-5C7GfCeVMHo@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hi Jean,

> As the mask used for smb_en_status doesn't depend on the value of
> "aux", this implies that on the Hudson-2, a single bit controls if both
> SMBus controllers are enabled. It's not possible to enable one and
> disable the other. Is it correct, or is it an overlook?

Good question. This is the current design, not an overlook.

> BTW it would be really great if we could have access to the
> documentation for these new AMD chipsets. I looked for both Hudson and
> FCH at http://developer.amd.com/ but these searches returned nothing. I
> could help better if I had access to the documentation / datasheets.

I don't know who is the website maintainer but forwarded your question
to our FCH datasheet maintainer, and he will follow up. I hope that it will
be improved in near future. :-)

BTW, will this patch appear from kernel 3.14-rc1 ?


Thanks,
Shane
