From: Michal Simek <michal.simek@xilinx.com>
Subject: Re: [PATCH] i2c: Enable Cadence driver for ARM64
Date: Mon, 26 Oct 2015 15:43:44 +0100
Message-ID: <562E3C20.10902@xilinx.com>
References: <893f828f3ac665d80746589af3617dc462315329.1445868589.git.michal.simek@xilinx.com>
 <20151026143236.GK597@x1>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20151026143236.GK597@x1>
Sender: linux-kernel-owner@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>, Michal Simek <michal.simek@xilinx.com>
Cc: linux-kernel@vger.kernel.org, monstr@monstr.eu, Andrew Bresticker <abrestic@chromium.org>, David Box <david.e.box@linux.intel.com>, Kamal Dasu <kdasu.kdev@gmail.com>, Wolfram Sang <wsa@the-dreams.de>, Javier Martinez Canillas <javier@osg.samsung.com>, Joachim Eastwood <manabian@gmail.com>, Zhangfei Gao <zhangfei.gao@linaro.org>, linux-i2c@vger.kernel.org, Geert Uytterhoeven <geert@linux-m68k.org>, Neelesh Gupta <neelegup@linux.vnet.ibm.com>, Subhendu Sekhar Behera <sbehera@broadcom.com>
List-Id: linux-i2c@vger.kernel.org

Hi,

On 10/26/2015 03:32 PM, Lee Jones wrote:
> Regarding your address list -- it's too big.  Most of your addressees
> don't care about this patch.  Please be more selective when sending
> patches to people, most of us have enough (relevant) mail as it is.

This is just what get_maintainer.pl is returning you. And I do use
patman (uboot tools) for ages and none has any problem with it. That's
why I am curious why you have the problem with it.

Thanks,
Michal
