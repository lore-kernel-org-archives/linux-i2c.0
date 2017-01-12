From: Dmitry Torokhov <dtor@kernel.org>
Subject: Re: [PATCH v2] i2c: do not enable fall back to Host Notify by default
Date: Thu, 12 Jan 2017 12:33:52 -0800
Message-ID: <20170112203352.GA17915@dtor-ws>
References: <20170105045722.GA17958@dtor-ws>
 <20170112184101.slxulrvreq7zl2pc@ninjato>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:50368 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750834AbdALUd4 (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Thu, 12 Jan 2017 15:33:56 -0500
Content-Disposition: inline
In-Reply-To: <20170112184101.slxulrvreq7zl2pc@ninjato>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Rob Herring <robh+dt@kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>, =?utf-8?B?TWljaGHFgiBLxJlwaWXFhA==?= <kernel@kempniu.pl>, Jean Delvare <jdelvare@suse.com>, Takashi Iwai <tiwai@suse.de>, linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org

On Thu, Jan 12, 2017 at 07:41:01PM +0100, Wolfram Sang wrote:
> On Wed, Jan 04, 2017 at 08:57:22PM -0800, Dmitry Torokhov wrote:
> > Falling back unconditionally to HostNotify as primary client's interrupt
> > breaks some drivers which alter their functionality depending on whether
> > interrupt is present or not, so let's introduce a board flag telling I2C
> > core explicitly if we want wired interrupt or HostNotify-based one:
> > I2C_CLIENT_HOST_NOTIFY.
> > 
> > For DT-based systems we introduce "host-notify" property that we convert
> > to I2C_CLIENT_HOST_NOTIFY board flag.
> > 
> > Tested-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
> > Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> 
> Applied to for-current, thanks!
> 
> How do we handle driver fixes? Shall I take them via I2C to have the
> dependency clear? Or can they go seperately?

The drivers that need this will go [hopefully] into next so they should
be OK to go through my tree.

-- 
Dmitry
