From: Jean Delvare <jdelvare@suse.de>
Subject: Re: [PATCH v9 1/2] i2c: i801: add support of Host Notify
Date: Mon, 1 Aug 2016 15:33:52 +0200
Message-ID: <20160801153352.44943aae@endymion>
References: <1466779189-8455-1-git-send-email-benjamin.tissoires@redhat.com>
	<20160718161245.5c744879@endymion>
	<20160728094457.GN19383@mail.corp.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:34520 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752038AbcHANyJ (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Mon, 1 Aug 2016 09:54:09 -0400
In-Reply-To: <20160728094457.GN19383@mail.corp.redhat.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: Wolfram Sang <wsa@the-dreams.de>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Andrew Duggan <aduggan@synaptics.com>, Christopher Heiny <cheiny@synaptics.com>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org

On Thu, 28 Jul 2016 11:44:57 +0200, Benjamin Tissoires wrote:
> On Jul 18 2016 or thereabouts, Jean Delvare wrote:
> > On Fri, 24 Jun 2016 16:39:49 +0200, Benjamin Tissoires wrote:
> > > The i801 chip can handle the Host Notify feature since ICH 3 as mentioned
> > > in http://www.intel.com/content/dam/doc/datasheet/82801ca-io-controller-hub-3-datasheet.pdf
> > > 
> > > Enable the functionality unconditionally and propagate the alert
> > > on each notification.
> > > 
> > > With a T440s and a Synaptics touchpad that implements Host Notify, the
> > > payload data is always 0x0000, so I am not sure if the device actually
> > > sends the payload or if there is a problem regarding the implementation.
> > 
> > Out of curiosity, does it work on at least one machine?
> 
> I have tested the T440, t450 and t460 (3 different generation of Intel
> processor), and none seems to be working. The Synaptics touchpad used is
> mostly the same, so maybe that's a device issue.

May I ask why you are pushing the code upstream then, if it has no
known (working) user?

-- 
Jean Delvare
SUSE L3 Support
