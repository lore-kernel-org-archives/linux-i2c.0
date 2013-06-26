From: Vineet Gupta <Vineet.Gupta1-HKixBCOQz3hWk0Htik3J/w@public.gmane.org>
Subject: Re: [PATCH v9] i2c-designware: make SDA hold time configurable
Date: Wed, 26 Jun 2013 09:53:36 +0530
Message-ID: <51CA6CC8.6070305@synopsys.com>
References: <20130620203716.GF2961@katana> <1371808422-27742-1-git-send-email-christian.ruppert@abilis.com> <20130625163902.GA2973@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20130625163902.GA2973@katana>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: Christian Ruppert <christian.ruppert-ux6zf3SgZrrQT0dZR+AlfA@public.gmane.org>, Rob Herring <robherring2-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "Ben Dooks (embedded platforms)" <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>, Rob Landley <rob-VoJi6FS/r0vR7s880joybQ@public.gmane.org>, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Pierrick Hascoet <pierrick.hascoet-ux6zf3SgZrrQT0dZR+AlfA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On 06/25/2013 10:09 PM, Wolfram Sang wrote:
> Hi,
>
> On Fri, Jun 21, 2013 at 11:53:42AM +0200, Christian Ruppert wrote:
>> > This patch makes the SDA hold time configurable through device tree.
>> > 
>> > Signed-off-by: Christian Ruppert <christian.ruppert-ux6zf3SgZrrQT0dZR+AlfA@public.gmane.org>
>> > Signed-off-by: Pierrick Hascoet <pierrick.hascoet-ux6zf3SgZrrQT0dZR+AlfA@public.gmane.org>
>> > ---
>> >  .../devicetree/bindings/i2c/i2c-designware.txt     |   14 ++++++++++++++
>> >  arch/arc/boot/dts/abilis_tb100_dvk.dts             |   10 +++++-----
>> >  arch/arc/boot/dts/abilis_tb101_dvk.dts             |   10 +++++-----
> Vineet, an ack for those would be nice since I think it is better if I
> take all this via I2C.
>

Certainly, I was waiting for you guys to converge :-)

Acked-by: Vineet Gupta <vgupta-HKixBCOQz3hWk0Htik3J/w@public.gmane.org>   # for arch/arc/boot/dts/*

-Vineet
