From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH 4/4] i2c: slave: add error messages to slave core
Date: Mon, 1 Jun 2015 08:30:01 +0900
Message-ID: <20150531233000.GB17187@katana>
References: <1431607205-2316-1-git-send-email-wsa@the-dreams.de>
 <1431607205-2316-5-git-send-email-wsa@the-dreams.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sh-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1431607205-2316-5-git-send-email-wsa@the-dreams.de>
Sender: linux-sh-owner@vger.kernel.org
To: linux-i2c@vger.kernel.org
Cc: linux-sh@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, Simon Horman <horms@verge.net.au>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Peter Huewe <peterhuewe@gmx.de>
List-Id: linux-i2c@vger.kernel.org

> -	if (!client || !slave_cb)
> +	if (!client || !slave_cb) {
> +		dev_err(&client->dev, "%s: insufficent data\n", __func__);

Replaced this with WARN. Using client->dev after potential !client is bad.

