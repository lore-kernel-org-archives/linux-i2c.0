Received: from out-172.mta1.migadu.com (out-172.mta1.migadu.com [95.215.58.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F8271DE8AE;
	Sat,  6 Jun 2026 17:39:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780767572; cv=none; b=h60/TLRE74Ox5dUpwFoR4pTk30OTEZe66av6yzDaiv13KGrWl1KuEuefGYfS8kacJbRRGZYOSeHEsCbiY5JfXP9F6I6NPkQKkYM8F6rcbZAho1nSaJ6eLLmd8PS1IRkmCvUUgK2keKlo7OsazDQMxcHDd3X8v1DqQwO5LCpUnSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780767572; c=relaxed/simple;
	bh=oQGdfj7uEqXm1ZQB33cf3nXCYtvvhWzcKlikkEASmsY=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=UMgajTcTnqrkDOReqnVRkM4KZP36Up1SlOpwmDb8zIPZooeOwS+4MC3UizFSNN1aEneJUbI2bJR30Eq1gWmsc1sW0tg52YYDuWtW0hBu65zudX+uQHUoX5aL8RO1csNm5abKQgxbiwoIZSK2zMwqZWVnVAdzSC050Tbax8LvuMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=TbKTYIx0; arc=none smtp.client-ip=95.215.58.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="TbKTYIx0"
Message-ID: <9e49b71b-8b60-479e-93e7-5c12e352c78e@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1780767568;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=WbmVZpwgZYYbPsnAr28/oo4q9yeFahfXu58rdbVOhf8=;
	b=TbKTYIx0ctWGTC1kcGLUE+WfKNJlrt8XoaXoy5oPX5esxYUYT/WsFI6meQjPfwAlD2z82+
	OdRPtuRYCIcfAcshpM59MhLdo5Kkig05y8EqnYlSMcDx/00IsAPuqBYgcH8HxpjqWLWxss
	/5fzZ2r1HnyixOc3pSrfESBr/JbFjSQ=
Date: Sat, 6 Jun 2026 18:39:19 +0100
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Language: en-US
To: Wolfram Sang <wsa@kernel.org>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Igor Korotin <igor.korotin@linux.dev>
Subject: [GIT PULL] rust-i2c-fixes for 7.1-rc7
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

The following changes since commit e43ffb69e0438cddd72aaa30898b4dc446f664f8:

   Linux 7.1-rc6 (2026-05-31 15:14:24 -0700)

are available in the Git repository at:

   https://github.com/ikrtn/linux.git tags/rust-i2c-7.1-rc7

for you to fetch changes up to 4eb422482ca5d924d7212ad2ca1cb7ea6f5b524d:

   rust: i2c: fix I2cAdapter refcounts double increment (2026-06-06 
15:19:27 +0100)

----------------------------------------------------------------
rust: i2c: fix I2cAdapter refcount double increment

A single bugfix for the Rust I2C abstractions, targeting 7.1.

`I2cAdapter::get` calls `i2c_get_adapter()` which returns a pointer with
an already-incremented refcount. The code then converts the raw pointer to
an `ARef` via `.into()`, which calls `inc_ref()` again through the
`From<&T> for ARef<T>` impl — resulting in a leaked device and module
reference on every call.

The fix uses `ARef::from_raw()` instead, which takes ownership of the
existing refcount without incrementing it.

Signed-off-by: Igor Korotin <igor.korotin@linux.dev>

----------------------------------------------------------------
Nicolás Antinori (1):
       rust: i2c: fix I2cAdapter refcounts double increment

  rust/kernel/i2c.rs | 4 +++-
  1 file changed, 3 insertions(+), 1 deletion(-)
