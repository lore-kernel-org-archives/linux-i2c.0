From: Vineet Gupta <Vineet.Gupta1-HKixBCOQz3hWk0Htik3J/w@public.gmane.org>
Subject: Re: [PATCH v10] i2c-designware: make SDA hold time configurable
Date: Wed, 26 Jun 2013 14:27:42 +0530
Message-ID: <51CAAD06.5080800@synopsys.com>
References: <20130625163902.GA2973@katana> <1372236906-6933-1-git-send-email-christian.ruppert@abilis.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1372236906-6933-1-git-send-email-christian.ruppert-ux6zf3SgZrrQT0dZR+AlfA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Christian Ruppert <christian.ruppert-ux6zf3SgZrrQT0dZR+AlfA@public.gmane.org>
Cc: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Rob Herring <robherring2-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "Ben Dooks (embedded platforms)" <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>, Rob Landley <rob-VoJi6FS/r0vR7s880joybQ@public.gmane.org>, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Pierrick Hascoet <pierrick.hascoet-ux6zf3SgZrrQT0dZR+AlfA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On 06/26/2013 02:25 PM, Christian Ruppert wrote:
> This patch makes the SDA hold time configurable through device tree.
>
> Signed-off-by: Christian Ruppert <christian.ruppert-ux6zf3SgZrrQT0dZR+AlfA@public.gmane.org>
> Signed-off-by: Pierrick Hascoet <pierrick.hascoet-ux6zf3SgZrrQT0dZR+AlfA@public.gmane.org>
> ---
>  .../devicetree/bindings/i2c/i2c-designware.txt     |   15 +++++++++++++++
>  arch/arc/boot/dts/abilis_tb100_dvk.dts             |   10 +++++-----
>  arch/arc/boot/dts/abilis_tb101_dvk.dts             |   10 +++++-----
>  drivers/i2c/busses/i2c-designware-core.c           |   13 +++++++++++++
>  drivers/i2c/busses/i2c-designware-core.h           |    1 +
>  drivers/i2c/busses/i2c-designware-platdrv.c        |   10 ++++++++++
>  6 files changed, 49 insertions(+), 10 deletions(-)

Acked-by: Vineet Gupta <vgupta-HKixBCOQz3hWk0Htik3J/w@public.gmane.org> for arch/arc bits

-Vineet
