From: Jean Delvare <jdelvare@suse.de>
Subject: Re: i2c-tools available commands
Date: Wed, 28 Oct 2015 13:53:31 +0100
Message-ID: <1446036811.4659.1054.camel@chaos.site>
References: <BN4PR12MB0753BFBF4E74CD966C61449CE6230@BN4PR12MB0753.namprd12.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:57891 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964963AbbJ1Mxe (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Wed, 28 Oct 2015 08:53:34 -0400
In-Reply-To: <BN4PR12MB0753BFBF4E74CD966C61449CE6230@BN4PR12MB0753.namprd12.prod.outlook.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Stephen Davis <stephen.davis@lumet.com>
Cc: "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>

Hi Stephen,

Le Monday 26 October 2015 =C3=A0 23:52 +0000, Stephen Davis a =C3=A9cri=
t :
> I have just started to use i2c-tools via the rasp2c module using
> nodejs on my Raspberry Pi. I have not been able to track down the
> commands that are available to i2c-tools. Is there a place where I ca=
n
> find this information?

I have no idea what rasp2c and nodejs are.

Commands included in i2c-tools are i2cdetect, i2cdump, i2cget and
i2cset. They all come with a manual page. Also included are
i2c-stub-from-dump, ddcmon, decode-dimms and decode-vaio but probably o=
f
lesser interest to you.

The exact list of commands included in your specific case depends what
the packager decided to do. I suppose that commands that are not
relevant on the Raspberry Pi are not included in the package.

--=20
Jean Delvare
SUSE L3 Support
