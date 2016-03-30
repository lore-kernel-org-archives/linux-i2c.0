From: Ben Dooks <ben.dooks@codethink.co.uk>
Subject: Re: [Linux-kernel] [PATCH] i2c: mux: demux-pinctrl: Fix reading the
 "master" attribute
Date: Wed, 30 Mar 2016 17:42:31 +0100
Message-ID: <56FC01F7.1060503@codethink.co.uk>
References: <1459355236.27975.5.camel@codethink.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from ducie-dc1.codethink.co.uk ([185.25.241.215]:37358 "EHLO
	ducie-dc1.codethink.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751107AbcC3Qmg (ORCPT
	<rfc822;linux-i2c@vger.kernel.org>); Wed, 30 Mar 2016 12:42:36 -0400
In-Reply-To: <1459355236.27975.5.camel@codethink.co.uk>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Ben Hutchings <ben.hutchings@codethink.co.uk>, Wolfram Sang <wsa@the-dreams.de>
Cc: CT kernel <linux-kernel@lists.codethink.co.uk>, linux-i2c@vger.kernel.org

On 30/03/16 17:27, Ben Hutchings wrote:
> sysfs attributes should use the same format for reads and writes,
> rather than pretty-printing on read.
> 
> Fixes: 50a5ba876908 ("i2c: mux: demux-pinctrl: add driver")
> Signed-off-by: Ben Hutchings <ben.hutchings@codethink.co.uk>

should that be moved to a debugfs entry or a read-only sysfs?

-- 
Ben Dooks				http://www.codethink.co.uk/
Senior Engineer				Codethink - Providing Genius
