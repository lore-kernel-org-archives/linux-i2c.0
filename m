Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10F897260D;
	Fri, 13 Feb 2026 16:07:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770998878; cv=none; b=AYiakBEkTXXJEA1+yGw7G4BTrguu8HbpewouhSx7e2g3tuJYh+vOL6eEu3xk+K+ZNKK/twM2jRiikPdGeIo3srNJ9c+j5rO2VtoeXOzWt02xJ+3IycdUCIV4NxyXF0ZTuKYyW5ckBfmuqeeNHdoU/4kvOgirMuCmT2xEnPEd39A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770998878; c=relaxed/simple;
	bh=eYClFG3ShEnRVZ11ugw8gYv94TsIFu9y1BPtb8U20Gg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ASt0clqqdME/Nc+/vMx33aWHkTXgDTVNvFKXhzoR5bzQ8oSknz3hWzU5UkLRDMi0A1R7HXGfeP+7uzuDSAsk3cOiA7eSxwq7pKbwA1xkElzWlo9Vn7Em5fkc5k7mhzRUaM+N3ukAilQm4yqEAUV0dA+P0rlqHwU3bjn/NzVZ8lU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iRLefP+T; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iRLefP+T"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770998877; x=1802534877;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=eYClFG3ShEnRVZ11ugw8gYv94TsIFu9y1BPtb8U20Gg=;
  b=iRLefP+ThLoEyIvoya9ztpal1ru4wivz0Y3gTLdLU6hWdJLsi/agUOOJ
   CI7tJNf7mfkPiWfvunugNEAmXDF50ygfpEiNOdZMvnF7WZ19Q056d5UFd
   9HgjFAhptTZ5sfU/6vYtNCB8iV/WFsmOEjPcrsFf4QBYIC41tL7FdhbAY
   DsH8DLBVIA86A5GMSdfRlLJDl2jlnxPaY1nYSwygXMshqmmwaCauV9hSX
   sSMXsOiLWiCLld1bZEGq6zqynNLABRQxh/SWuAqgRvDh7EGzBZmIMVJTK
   DWxV7J/4KLwdY1kwyO1BsCpfPv6nOFuR8zmj/SpjaAjEUlVnaBvIXQskW
   A==;
X-CSE-ConnectionGUID: t33wyiuwTtGKFl5020AYww==
X-CSE-MsgGUID: H7eO17dAQfC5IEgBm4yeTQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11700"; a="76033630"
X-IronPort-AV: E=Sophos;i="6.21,288,1763452800"; 
   d="scan'208";a="76033630"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2026 08:07:52 -0800
X-CSE-ConnectionGUID: 6+WtOFBOSDqWQAnSu52cuA==
X-CSE-MsgGUID: aIU/z1bNQIakasBkvGX2Bg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,288,1763452800"; 
   d="scan'208";a="243554041"
Received: from igk-lkp-server01.igk.intel.com (HELO e5404a91d123) ([10.211.93.152])
  by orviesa002.jf.intel.com with ESMTP; 13 Feb 2026 08:07:49 -0800
Received: from kbuild by e5404a91d123 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vqvhr-000000001d7-07UM;
	Fri, 13 Feb 2026 16:07:47 +0000
Date: Fri, 13 Feb 2026 17:07:05 +0100
From: kernel test robot <lkp@intel.com>
To: Marcus Folkesson <marcus.folkesson@gmail.com>,
	Wolfram Sang <wsa-dev@sang-engineering.com>,
	Peter Rosin <peda@axentia.se>,
	Michael Hennerich <michael.hennerich@analog.com>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Andi Shyti <andi.shyti@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	Marcus Folkesson <marcus.folkesson@gmail.com>
Subject: Re: [PATCH v5 5/5] docs: i2c: i2c-topology: add section about bus
 speed
Message-ID: <202602131725.COjgPVue-lkp@intel.com>
References: <20260213-i2c-mux-v5-5-fb2cbf9979b3@gmail.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260213-i2c-mux-v5-5-fb2cbf9979b3@gmail.com>

Hi Marcus,

kernel test robot noticed the following build warnings:

[auto build test WARNING on 1f97d9dcf53649c41c33227b345a36902cbb08ad]

url:    https://github.com/intel-lab-lkp/linux/commits/Marcus-Folkesson/i2c-core-add-callback-to-change-bus-frequency/20260213-191801
base:   1f97d9dcf53649c41c33227b345a36902cbb08ad
patch link:    https://lore.kernel.org/r/20260213-i2c-mux-v5-5-fb2cbf9979b3%40gmail.com
patch subject: [PATCH v5 5/5] docs: i2c: i2c-topology: add section about bus speed
compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
docutils: docutils (Docutils 0.21.2, Python 3.13.5, on linux)
reproduce: (https://download.01.org/0day-ci/archive/20260213/202602131725.COjgPVue-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202602131725.COjgPVue-lkp@intel.com/

All warnings (new ones prefixed by >>):

   The parent of level 2 sections cannot be reached. The parser is at section level 2 but the current node has only 0 parent section(s).
   One reason may be a high level section used in a directive that parses its content into a base node not attached to the document
   (up to Docutils 0.21, these sections were silently dropped). [docutils]
>> Documentation/i2c/i2c-topology.rst:436: WARNING: Literal block ends without a blank line; unexpected unindent. [docutils]
   Documentation/i2c/i2c-topology.rst:531: ERROR: Unexpected indentation. [docutils]
>> Documentation/i2c/i2c-topology.rst:532: WARNING: Block quote ends without a blank line; unexpected unindent. [docutils]


vim +436 Documentation/i2c/i2c-topology.rst

   429	
   430	                          .----------. 100kHz .--------.
   431	        .--------. 400kHz |   mux-   |--------| dev D2 |
   432	        |  root  |--+-----|  locked  |        '--------'
   433	        '--------'        |  mux M1  |--. 400kHz .--------.
   434	                          '----------'  '--------| dev D1 |
   435	                                                 '--------'
 > 436	Locking
   437	--------
   438	
   439	If the multiplexer is mux-locked, transfers to D3 may interleave between the
   440	select-transfer-deselect to D1 or D2.
   441	This results in a situation where the bus speed to D3 may be lower than it
   442	is supposed to be. This is usually not a problem.
   443	
   444	This topology is allowed but some transfers to D3 may be at 100kHz: ::
   445	
   446	                          .----------. 100kHz .--------.
   447	        .--------. 400kHz |   mux-   |--------| dev D1 |
   448	        |  root  |--+-----|  locked  |        '--------'
   449	        '--------'  |     |  mux M1  |--. 400kHz .--------.
   450	                    |     '----------'  '--------| dev D2 |
   451	                    |  .--------.                '--------'
   452	                    '--| dev D3 |
   453	                       '--------'
   454	
   455	Multiple muxes in series
   456	--------------------------
   457	
   458	When multiple muxes are used in series the same rules applies.
   459	
   460	Transfers to D3 may interleave between select-transfer-deselect to D1, which
   461	results that the bus speed to D2 or D3 will be at 100KHz.
   462	
   463	Transfers to D2 may interleave between select-transfer-deselect to D1, which
   464	results in that the bus speed to D1 may be at 400kHz as the transfer to D2
   465	will set the bus speed to before the transfer to D1 starts.
   466	
   467	This is probably a bad topology ::
   468	
   469	                     .----------. 400kHz .----------. 100kHz .--------.
   470	    .--------.400kHz |   mux-   |--------|   mux-   |--------| dev D1 |
   471	    |  root  |--+----|  locked  | 400kHz |  locked  |        '--------'
   472	    '--------'  |    |  mux M1  |--.     |  mux M2  |
   473	                |    '----------'  |     '----------'
   474	                |  .--------.      |  .--------.
   475	                '--| dev D3 |      '--| dev D2 |
   476	                   '--------'         '--------'
   477	
   478	Multiple muxes in parallell
   479	----------------------------
   480	
   481	When multiple muxes are used in parallell all access to other muxes are locked out
   482	so this is not a problem.
   483	
   484	If the muxes are mux-locked, access to D3 may still interleave though.
   485	
   486	In the example below, D3 may not interleave between select-transfer-deselect for D1
   487	or D2 as both muxes are parent-locked: ::
   488	
   489	
   490	                   .----------. 100kHz   .--------.
   491	                   |  parent- |----------| dev D1 |
   492	                .--|  locked  |          '--------'
   493	                |  |  mux M1  |
   494	                |  '----------'
   495	                |      .----------. 400KHz  .--------.
   496	    .--------. 400kHz  |  parent- |---------| dev D2 |
   497	    |  root  |--+------|  locked  |         '--------'
   498	    '--------'  |      |  mux M2  |
   499	                |      '----------'
   500	                |  .--------.
   501	                '--| dev D3 |
   502	                   '--------'
   503	
   504	Idle state
   505	-----------
   506	
   507	Muxes have an idle state, which is the state the channels is put into when no channel
   508	is active. The state is typically one of the following:
   509	
   510	- All channels are disconnected
   511	- The last selected channel is left as-is
   512	- A predefined channel is selected
   513	
   514	Muxes that support an idle state where all channels are disconnected are preferred when using
   515	different bus speeds. Otherwise high bus speeds may "leak" through to devices that
   516	may not support that higher speed.
   517	
   518	Consider the following example: ::
   519	
   520	                          .----------. 100kHz .--------.
   521	        .--------. 400kHz |   mux-   |--------| dev D1 |
   522	        |  root  |--+-----|  locked  |        '--------'
   523	        '--------'  |     |  mux M1  |--. 400kHz .--------.
   524	                    |     '----------'  '--------| dev D2 |
   525	                    |  .--------.                '--------'
   526	                    '--| dev D3 |
   527	                       '--------'
   528	
   529	If the idle state of M1 is:
   530	- All channels disconnected: No problem, D1 and D2 are not affected by communication
   531	  to D3.
 > 532	- Last selected channel: Problem if D1 was the last selected channel. High speed
   533	  communication to D3 will be "leaked" to D1.
   534	- Predefined channel: Problem, if the predefined channel D1. Set predefined channel
   535	  to D2 as D2 may handle 400kHz.
   536	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
