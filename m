From: Ben Dooks <ben.dooks@codethink.co.uk>
Subject: Re: [PATCHv2] i2c: meson: allow build with COMPILE_TEST
Date: Wed, 6 Jul 2016 08:33:48 +0100
Message-ID: <5de63894-cb33-f2be-4c53-93e8865a24a9@codethink.co.uk>
References: <1467742788-16431-1-git-send-email-ben.dooks@codethink.co.uk>
 <1467743043-18703-1-git-send-email-ben.dooks@codethink.co.uk>
 <20160706000935.GA1349@tetsubishi>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from ducie-dc1.codethink.co.uk ([185.25.241.215]:44888 "EHLO
	ducie-dc1.codethink.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750883AbcGFHdy (ORCPT
	<rfc822;linux-i2c@vger.kernel.org>); Wed, 6 Jul 2016 03:33:54 -0400
In-Reply-To: <20160706000935.GA1349@tetsubishi>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-kernel@lists.codethink.co.uk, Ben Dooks <ben-linux@fluff.org>, linux-amlogic@lists.infradead.org, linux-i2c@vger.kernel.org

On 06/07/16 01:09, Wolfram Sang wrote:
> On Tue, Jul 05, 2016 at 07:24:03PM +0100, Ben Dooks wrote:
>> From: Ben Dooks <ben-linux@fluff.org>
>>
>> This driver could be included in COMPILE_TEST so allow it to be
>> compiled when COMPILE_TEST is selected.
>>
>> Signed-off-by: Ben Dooks <ben-linux@fluff.org>
>> Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
> 
> Two signed-offs by you?

two different emails, got a patch written at home left in my work
tree so used both emails.

-- 
Ben Dooks				http://www.codethink.co.uk/
Senior Engineer				Codethink - Providing Genius
