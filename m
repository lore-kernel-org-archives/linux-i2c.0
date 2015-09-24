From: Peter Korsgaard <peter@korsgaard.com>
Subject: Re: [PATCH v2] i2c-ocores: support big-endian register layout
Date: Thu, 24 Sep 2015 23:31:54 +0200
Message-ID: <87bncro65x.fsf@dell.be.48ers.dk>
References: <1442990103-13456-1-git-send-email-jcmvbkbc@gmail.com>
	<87wpvfoaly.fsf@dell.be.48ers.dk>
	<CAMo8BfKh_bF-MbmsFGzTdrsqyGeTDqthDzfsRxsTnAgYBBHGhg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-wi0-f182.google.com ([209.85.212.182]:34779 "EHLO
	mail-wi0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754230AbbIXVb6 (ORCPT
	<rfc822;linux-i2c@vger.kernel.org>); Thu, 24 Sep 2015 17:31:58 -0400
In-Reply-To: <CAMo8BfKh_bF-MbmsFGzTdrsqyGeTDqthDzfsRxsTnAgYBBHGhg@mail.gmail.com>
	(Max Filippov's message of "Fri, 25 Sep 2015 00:20:04 +0300")
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Max Filippov <jcmvbkbc@gmail.com>
Cc: linux-i2c@vger.kernel.org, Peter Korsgaard <jacmet@sunsite.dk>, Wolfram Sang <wsa@the-dreams.de>, LKML <linux-kernel@vger.kernel.org>

>>>>> "Max" == Max Filippov <jcmvbkbc@gmail.com> writes:

Hi,

 >> You should also document the big-endian property in
 >> Documentation/devicetree/bindings/i2c/i2c-ocores.txt, otherwise it looks
 >> good.

 > 'big-endian' and 'native-endian' are common properties documented
 > in the Documentation/devicetree/bindings/common-properties.txt

Ok, then it looks good to me.

-- 
Bye, Peter Korsgaard
