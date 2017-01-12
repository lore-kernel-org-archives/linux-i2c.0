From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v2] i2c: do not enable fall back to Host Notify by default
Date: Thu, 12 Jan 2017 19:41:01 +0100
Message-ID: <20170112184101.slxulrvreq7zl2pc@ninjato>
References: <20170105045722.GA17958@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170105045722.GA17958@dtor-ws>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Rob Herring <robh+dt@kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>, =?utf-8?B?TWljaGHFgiBLxJlwaWXFhA==?= <kernel@kempniu.pl>, Jean Delvare <jdelvare@suse.com>, Takashi Iwai <tiwai@suse.de>, linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
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

Applied to for-current, thanks!

How do we handle driver fixes? Shall I take them via I2C to have the
dependency clear? Or can they go seperately?
