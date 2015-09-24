From: Peter Korsgaard <peter@korsgaard.com>
Subject: Re: [PATCH v2] i2c-ocores: support big-endian register layout
Date: Thu, 24 Sep 2015 21:55:53 +0200
Message-ID: <87wpvfoaly.fsf@dell.be.48ers.dk>
References: <1442990103-13456-1-git-send-email-jcmvbkbc@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-wi0-f176.google.com ([209.85.212.176]:33585 "EHLO
	mail-wi0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751468AbbIXT4J (ORCPT
	<rfc822;linux-i2c@vger.kernel.org>); Thu, 24 Sep 2015 15:56:09 -0400
In-Reply-To: <1442990103-13456-1-git-send-email-jcmvbkbc@gmail.com> (Max
	Filippov's message of "Wed, 23 Sep 2015 09:35:03 +0300")
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Max Filippov <jcmvbkbc@gmail.com>
Cc: linux-i2c@vger.kernel.org, Peter Korsgaard <jacmet@sunsite.dk>, Wolfram Sang <wsa@the-dreams.de>, linux-kernel@vger.kernel.org

>>>>> "Max" == Max Filippov <jcmvbkbc@gmail.com> writes:

 > This allows using OpenCores I2C controller attached to its host in
 > native-endian mode with bi-endian CPUs. Example of such system is Xtensa
 > XTFPGA platform.

 > Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
 > ---
 > Changes v1->v2:
 > - expand changelog with motivation for the change.

You should also document the big-endian property in
Documentation/devicetree/bindings/i2c/i2c-ocores.txt, otherwise it looks
good.

With that added:

Acked-by: Peter Korsgaard <peter@korsgaard.com>

-- 
Bye, Peter Korsgaard
