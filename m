From: Ben Dooks <ben.dooks@codethink.co.uk>
Subject: Re: [PATCH v2] i2c: meson: allow build with COMPILE_TEST
Date: Thu, 7 Jul 2016 09:05:49 +0100
Message-ID: <91720673-d156-45c7-a66d-5e6d843efa3d@codethink.co.uk>
References: <1467836225-2427-1-git-send-email-ben-linux@fluff.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from ducie-dc1.codethink.co.uk ([185.25.241.215]:52672 "EHLO
	ducie-dc1.codethink.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756266AbcGGIFz (ORCPT
	<rfc822;linux-i2c@vger.kernel.org>); Thu, 7 Jul 2016 04:05:55 -0400
In-Reply-To: <1467836225-2427-1-git-send-email-ben-linux@fluff.org>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Ben Dooks <ben-linux@fluff.org>, linux-kernel@lists.codethink.co.uk, linux-amlogic@lists.infradead.org, linux-i2c@vger.kernel.org, wsa@the-dreams.de

On 06/07/16 21:17, Ben Dooks wrote:
> This driver should be buildable with COMPILE_TEST so
> add this to the dependency for it.
> 
> Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
> ---
> V2:
> - reduced to just personal signnoff.

the first one was better :(

-- 
Ben Dooks				http://www.codethink.co.uk/
Senior Engineer				Codethink - Providing Genius
