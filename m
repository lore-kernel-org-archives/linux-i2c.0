From: Ben Hutchings <ben.hutchings@codethink.co.uk>
Subject: Re: [Linux-kernel] [PATCH] i2c: mux: demux-pinctrl: Fix reading the
 "master" attribute
Date: Wed, 30 Mar 2016 17:45:27 +0100
Message-ID: <1459356327.27975.7.camel@codethink.co.uk>
References: <1459355236.27975.5.camel@codethink.co.uk>
	 <56FC01F7.1060503@codethink.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from ducie-dc1.codethink.co.uk ([185.25.241.215]:37492 "EHLO
	ducie-dc1.codethink.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932065AbcC3Qpf (ORCPT
	<rfc822;linux-i2c@vger.kernel.org>); Wed, 30 Mar 2016 12:45:35 -0400
In-Reply-To: <56FC01F7.1060503@codethink.co.uk>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Ben Dooks <ben.dooks@codethink.co.uk>
Cc: Wolfram Sang <wsa@the-dreams.de>, CT kernel <linux-kernel@lists.codethink.co.uk>, linux-i2c@vger.kernel.org

On Wed, 2016-03-30 at 17:42 +0100, Ben Dooks wrote:
> On 30/03/16 17:27, Ben Hutchings wrote:
> > sysfs attributes should use the same format for reads and writes,
> > rather than pretty-printing on read.
> > 
> > Fixes: 50a5ba876908 ("i2c: mux: demux-pinctrl: add driver")
> > Signed-off-by: Ben Hutchings <ben.hutchings@codethink.co.uk>
> 
> should that be moved to a debugfs entry or a read-only sysfs?

Probably another read-only attribute (like "scaling_governor" vs
"scaling_available_governors" in cpufreq).

Ben.

-- 
Ben Hutchings
Software Developer, Codethink Ltd.
