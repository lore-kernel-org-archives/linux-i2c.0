From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v2] i2c: do not enable fall back to Host Notify by default
Date: Mon, 9 Jan 2017 11:56:17 -0600
Message-ID: <20170109175617.ovwrfmkyafvc7uiy@rob-hp-laptop>
References: <20170105045722.GA17958@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170105045722.GA17958@dtor-ws>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Wolfram Sang <wsa@the-dreams.de>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>, =?utf-8?B?TWljaGHFgiBLxJlwaWXFhA==?= <kernel@kempniu.pl>, Jean Delvare <jdelvare@suse.com>, Takashi Iwai <tiwai@suse.de>, linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

On Wed, Jan 04, 2017 at 08:57:22PM -0800, Dmitry Torokhov wrote:
> Falling back unconditionally to HostNotify as primary client's interrupt
> breaks some drivers which alter their functionality depending on whether
> interrupt is present or not, so let's introduce a board flag telling I2C
> core explicitly if we want wired interrupt or HostNotify-based one:
> I2C_CLIENT_HOST_NOTIFY.
> 
> For DT-based systems we introduce "host-notify" property that we convert
> to I2C_CLIENT_HOST_NOTIFY board flag.
> 
> Tested-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> ---
> 
> v1->v2:
> 
> - of_read_property_bool -> of_property_read_bool
> - did not change binding wording to avoit mentioning I2C core because we
>   use the same wording (mentioning I2C core) for wired interrupts
> 
>  Documentation/devicetree/bindings/i2c/i2c.txt |  8 ++++++++

Acked-by: Rob Herring <robh@kernel.org>

>  drivers/i2c/i2c-core.c                        | 17 ++++++++---------
>  include/linux/i2c.h                           |  1 +
>  3 files changed, 17 insertions(+), 9 deletions(-)
