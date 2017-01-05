From: Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
Subject: Re: [PATCH v2] i2c: do not enable fall back to Host Notify by default
Date: Thu, 5 Jan 2017 13:39:00 +0100
Message-ID: <20170105123900.GE31083@pali>
References: <20170105045722.GA17958@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:33005 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1032048AbdAEMjE (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Thu, 5 Jan 2017 07:39:04 -0500
Content-Disposition: inline
In-Reply-To: <20170105045722.GA17958@dtor-ws>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Wolfram Sang <wsa@the-dreams.de>, Rob Herring <robh+dt@kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, =?utf-8?B?TWljaGHFgiBLxJlwaWXFhA==?= <kernel@kempniu.pl>, Jean Delvare <jdelvare@suse.com>, Takashi Iwai <tiwai@suse.de>, linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org

On Wednesday 04 January 2017 20:57:22 Dmitry Torokhov wrote:
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

Acked-by: Pali Rohár <pali.rohar@gmail.com>

-- 
Pali Rohár
pali.rohar@gmail.com
