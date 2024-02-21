Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C73446420
	for <linux-i2c@vger.kernel.org>; Wed, 21 Feb 2024 11:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708516108; cv=none; b=ZrEhzFxVNqNKhklLmsZWjpBXEIHDzt9ATDg/5kNA5jBk+q61hhOugypNFLTNvxQa/ULE30LFdlut8df/FvCGAK4zVrY0vFrzU7zoks2peUOFz4DIQXxo1QKECy78Flxohov3DOBADsYxSqWPUxkMixoa/MOAUtxgzW2WhM/2ico=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708516108; c=relaxed/simple;
	bh=cB182svhvuZ/FFbWweiD+PX0jtc4FXt22DG27z8JEVk=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=Ct3cxFdp14/1/T4M20NtpGQyKOQF7GT55N91UdtBXNyGV+gRlVTha5QAJbSLLzUbcHX9TekSW2/wDqSyzDBpyagjyPKN5XjoncGIaboJKno4IYY+UutqO+o1ITN5fg/emjTqLXiI7tQjoImG7Mma3F4wmuDd9WroEiD4/Cj9lhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hVN+xFJN; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hVN+xFJN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708516107; x=1740052107;
  h=message-id:date:mime-version:to:cc:from:subject:
   content-transfer-encoding;
  bh=cB182svhvuZ/FFbWweiD+PX0jtc4FXt22DG27z8JEVk=;
  b=hVN+xFJNnu7WMDFHnUG6NADHJ4TqVuaZMMA3LXmxdIdvLyqVWethrLTf
   Yozkaw63EcFTHJxz+sxNoAayoZT+2AOxDRSkkKCDpccm8CNb25nSX4TCQ
   QXEqNdjdhX+y2T1tjLDkmJjOHjlrctccN4RhGTZb0nPTg2OzK35X1Ue8v
   GOmZo0ENNphZ3OPPdvP9If9hp7QpXI9bKQ7Sa1vWqXPQxN6ZiMJzOHW2z
   AlkmqUKTDWlA03TXlfzXExvnWIqyBvCaf5vlbylVTpiTEy4sF8jBouQmS
   NAFSQ20TzzR6VjU56az+e3aAYi25jKvWcVSrYZLsfyq5htfj5mt+I0QSE
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10990"; a="5624797"
X-IronPort-AV: E=Sophos;i="6.06,175,1705392000"; 
   d="scan'208";a="5624797"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2024 03:48:26 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,175,1705392000"; 
   d="scan'208";a="9700796"
Received: from pzakowsk-mobl2.ger.corp.intel.com (HELO [10.94.252.46]) ([10.94.252.46])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2024 03:48:24 -0800
Message-ID: <635a719b-84f1-4460-b4f5-ab6327de9474@linux.intel.com>
Date: Wed, 21 Feb 2024 12:48:21 +0100
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: jdelvare@suse.de, linux-i2c@vger.kernel.org
Cc: piotr.zakowski@intel.com, alexander.sverdlin@gmail.com,
 andi.shyti@kernel.org, oren.shepon@intel.com, pawel.kozlowski@intel.com,
 alexander.usyskin@intel.com, jakub.radtke@intel.com
From: "Zakowski, Piotr" <piotr.zakowski@linux.intel.com>
Subject: Re: [PATCH] i2c: i801: Fix block process call transactions
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

> Piotr, does this change make your tests succeed?
Hi Jean,

I applied your change and test now passes the expectations.

Could I confirm with you ioctl() response convention:
It is expected from driver to return +1 Byte (Byte Count as first byte 
together with the actual data) in read block commands (i.e. Block Read 
Command and Block Write - Block Read Process Call)?

For example:

Data: 0x5a 0x82 0x64 0xB9 (4 Bytes)
Return of ioctl() call of Block Read command: 0x04 0x5a 0x82 0x64 0xB9

Best regards,
Piotr

