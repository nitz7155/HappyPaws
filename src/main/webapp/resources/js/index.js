// 공지사항
fetch('/notice_index').then(response => response.json()).then(data => {
	let section = document.querySelector("#notice-section");
	section.innerHTML = '';

	const aTag = document.createElement('a');
	const pTag = document.createElement('p');
	pTag.textContent = data.n_title;
	aTag.appendChild(pTag);
	aTag.href = "/board/notice_view?n_seq=" + data.n_seq;
	section.appendChild(aTag);
}).catch(error => console.error('데이터를 가져오는 중 오류 발생:', error));

// 글 분류
const cmtyCategoryList = {
	'General': '자유',
	'FoundReview': '후기',
	'AdoptionReview': '후기'
}
const cmtyColorList = {
	'General': '#3535e9',
	'FoundReview': 'red',
	'AdoptionReview': 'green'
}

// 커뮤니티
fetch('/cmty_index').then(response => response.json()).then(data => {
	let tbody = document.querySelector("#community-article tbody");
	tbody.innerHTML = '';

	data.forEach(item => {
		const row = document.createElement('tr');

		const categoryCell = document.createElement('td');
		categoryCell.textContent = cmtyCategoryList[item.cmty_category];
		categoryCell.style = "color: " + cmtyColorList[item.cmty_category];
		row.appendChild(categoryCell);

		const titleCell = document.createElement('td');
		titleCell.textContent = item.cmty_title;
		row.appendChild(titleCell);

		tbody.appendChild(row);
		row.addEventListener('click', () => location.href = "/board/cmty_view?cmty_seq=" + item.cmty_seq + "&cmty_category=all");
	});
}).catch(error => console.error('데이터를 가져오는 중 오류 발생:', error));

// 반려용품
fetch('/product/pr_index').then(response => response.json()).then(data => {
	let tbody = document.querySelector("#shop-article tbody");
	tbody.innerHTML = '';

	data.forEach(item => {
		const row = document.createElement('tr');

		const thumbnailCell = document.createElement('td');
        const thumbnail = document.createElement('img');
		thumbnail.src = "/resources/upload/"+item.pr_thumbnail;
		thumbnail.onerror = function () { thumbnail.onerror = null; thumbnail.src = '/resources/img/default.png'; };
		thumbnail.alt = item.pr_name;
		thumbnailCell.appendChild(thumbnail);
		row.appendChild(thumbnailCell);

		const nameCell = document.createElement('td');
		nameCell.textContent = item.pr_name;
		row.appendChild(nameCell);

		tbody.appendChild(row);
		row.addEventListener('click', () => location.href = "/product/pr_detail?pr_id=" + item.pr_id);
	});
}).catch(error => console.error('데이터를 가져오는 중 오류 발생:', error));

// 애완동물 분류
const miaCategoryList = {
	'dog': '강아지',
	'cat': '고양이',
	'small': '소동물',
	'etc': '기타'
}
const miaColorList = {
	'dog': 'brown',
	'cat': 'blueviolet',
	'small': 'seagreen',
	'etc': 'deeppink'
}

// 아이를 찾아주세요
fetch('/MIA/getLostPetListIndex').then(response => response.json()).then(data => {
	let tbody = document.querySelector("#lostPet-article tbody");
	tbody.innerHTML = '';

	data.forEach(item => {
		const row = document.createElement('tr');

		const categoryCell = document.createElement('td');
		categoryCell.textContent = miaCategoryList[item.lp_category];
		categoryCell.style = "color: " + miaColorList[item.lp_category];
		row.appendChild(categoryCell);

		const imgCell = document.createElement('td');
        const img = document.createElement('img');
		img.src = "/resources/MIA-img/lostPetImg/" + item.lp_img;
		img.onerror = function () { img.onerror = null; img.src = '/resources/img/default.png'; };
		img.alt = item.lp_title;
		imgCell.appendChild(img);
		row.appendChild(imgCell);

		const titleCell = document.createElement('td');
		titleCell.textContent = item.lp_title;
		row.appendChild(titleCell);

		const placeCell = document.createElement('td');
		placeCell.textContent = item.lp_place;
		row.appendChild(placeCell);

		tbody.appendChild(row);
		row.addEventListener('click', () => location.href = "/MIA/getLostPet?lp_seq=" + item.lp_seq + "&searchCondition=TITLE&searchKeyword=&category=&nowPage=1");
	});
}).catch(error => console.error('데이터를 가져오는 중 오류 발생:', error));

// 새로운 가족을 찾아요
fetch('/MIA/getNewFamilyListIndex').then(response => response.json()).then(data => {
	let tbody = document.querySelector("#newFamily-article tbody");
	tbody.innerHTML = '';

	data.forEach(item => {
		const row = document.createElement('tr');

		const categoryCell = document.createElement('td');
		categoryCell.textContent = miaCategoryList[item.nf_category];
		categoryCell.style = "color: " + miaColorList[item.nf_category];
		row.appendChild(categoryCell);

		const imgCell = document.createElement('td');
        const img = document.createElement('img');
		img.src = "/resources/MIA-img/newFamilyImg/" + item.nf_img;
		img.onerror = function () { img.onerror = null; img.src = '/resources/img/default.png'; };
		img.alt = item.nf_title;
		imgCell.appendChild(img);
		row.appendChild(imgCell);

		const titleCell = document.createElement('td');
		titleCell.textContent = item.nf_title;
		row.appendChild(titleCell);

		const placeCell = document.createElement('td');
		placeCell.textContent = item.nf_place;
		row.appendChild(placeCell);

		tbody.appendChild(row);
		row.addEventListener('click', () => location.href = "/MIA/getNewFamily?nf_seq=" + item.nf_seq + "&searchCondition=TITLE&searchKeyword=&category=&nowPage=1");
	});
}).catch(error => console.error('데이터를 가져오는 중 오류 발생:', error));