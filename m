From: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Subject: Re: [PATCH 1/2] i2c: implement i2c_verify_adapter
Date: Tue, 24 Apr 2012 10:55:15 -0600
Message-ID: <4F96DAF3.9000700@wwwdotorg.org>
References: <1334688214-8400-1-git-send-email-swarren@wwwdotorg.org> <20120417204925.29de7775@endymion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20120417204925.29de7775-R0o5gVi9kd7kN2dkZ6Wm7A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Stephen Warren <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On 04/17/2012 12:49 PM, Jean Delvare wrote:
> Hi Stephen,
> 
> On Tue, 17 Apr 2012 12:43:33 -0600, Stephen Warren wrote:
>> From: Stephen Warren <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
>>
>> This converts a struct device * to a struct i2c_adapter * while verifying
>> that the device really is an I2C adapter. Just like i2c_verify_client.
...
> I am fine with this patch:
> 
> Acked-by: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
> 
> I can merge it if you want, but if it is easier for you to merge it
> through a different tree, this is equally fine with me, just let me
> know what you prefer.

Wolfram, since the other I2C mux changes are going through your tree,
could you please merge this series too; they are a dependency for my
pinctrl-based I2C mux. Thanks!
